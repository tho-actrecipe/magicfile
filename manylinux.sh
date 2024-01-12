#!/bin/bash
set -e -x

# Install dependencies needed by our wheel
yum -y install gcc libffi-devel wget

wget -O /tmp/file.tar.gz http://archive.ubuntu.com/ubuntu/pool/main/f/file/file_5.45.orig.tar.gz
cd /tmp && tar zxf file.tar.gz && cd -
cd /tmp/file-5.45 && ./configure && make && make install && cd -

for PYBIN in /opt/python/cp3*/bin; do
    "${PYBIN}/python" setup.py bdist_wheel
done

for whl in dist/magicfile*.whl; do
    auditwheel repair "$whl" -w dist/
    rm "$whl"
done
