#!/bin/bash
set -e -x

# Install dependencies needed by our wheel
yum -y install gcc libffi-devel xz

wget -O /tmp/file.tar.xz http://archive.ubuntu.com/ubuntu/pool/main/f/file/file_5.32.orig.tar.xz
cd /tmp && xz -cd /tmp/file.tar.xz | tar x && cd -
cd /tmp/file-5.32 && ./configure && make && make install && cd -

# Build wheels
which linux32 && LINUX32=linux32
$LINUX32 /opt/python/cp27-cp27mu/bin/python setup.py bdist_wheel

# Audit wheels
for wheel in dist/*-linux_*.whl; do
  auditwheel repair $wheel -w dist/
  rm $wheel
done
