#!/bin/bash
set -e -x

# Install dependencies needed by our wheel
yum -y install gcc libffi-devel wget

# Download and install the correct version of the 'file' utility
wget -O /tmp/file.tar.gz http://archive.ubuntu.com/ubuntu/pool/main/f/file/file_5.38.orig.tar.gz
cd /tmp && tar zxf file.tar.gz && cd -
cd /tmp/file-5.38 && ./configure && make && make install && cd -

# Continue with your original script
for PYBIN in /opt/python/cp3*/bin; do
    # Skip Python 3.13 binaries
    if [[ "${PYBIN}" == *cp313* ]]; then
        echo "Skipping Python 3.13: ${PYBIN}"
        continue
    fi
    "${PYBIN}/python" -m pip install --upgrade pip
    "${PYBIN}/pip" install setuptools wheel cffi
    "${PYBIN}/python" setup.py bdist_wheel
done

for whl in dist/actrecipemagicfile*.whl; do
    auditwheel repair "$whl" -w dist/
    rm "$whl"
done
