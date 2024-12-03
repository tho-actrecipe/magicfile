#!/bin/bash
set -e -x

# Install system dependencies required for building the wheel
yum -y install gcc libffi-devel wget tar gzip

# Download and install the correct version of the 'file' utility
FILE_VERSION="5.38"
wget -O /tmp/file.tar.gz "http://archive.ubuntu.com/ubuntu/pool/main/f/file/file_${FILE_VERSION}.orig.tar.gz"
cd /tmp
tar -zxf file.tar.gz
cd "file-${FILE_VERSION}"
./configure
make
make install
cd -

# Build Python wheels for all available Python versions
for PYBIN in /opt/python/cp3*/bin; do
    "${PYBIN}/pip" install -U setuptools wheel  # Ensure setuptools and wheel are up-to-date
    "${PYBIN}/python" setup.py bdist_wheel
done

# Use auditwheel to repair built wheels
for whl in dist/actrecipemagicfile*.whl; do
    auditwheel repair "$whl" -w dist/
    rm "$whl"
done

# Clean up temporary files
rm -rf /tmp/file*