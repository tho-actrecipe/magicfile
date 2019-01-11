#!/bin/bash
set -e -x

# Install dependencies needed by our wheel
yum -y install gcc libffi-devel xz wget

wget -O /tmp/file.tar.xz http://archive.ubuntu.com/ubuntu/pool/main/f/file/file_5.32.orig.tar.xz
cd /tmp && xz -cd /tmp/file.tar.xz | tar x && cd -
cd /tmp/file-5.32 && ./configure && make && make install && cd -

for PYBIN in /opt/python/cp3*/bin; do
    "${PYBIN}/python" setup.py bdist_wheel
done

for whl in dist/magicfile*.whl; do
    auditwheel repair "$whl" -w dist/
done
