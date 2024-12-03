#!/bin/sh


# ensure we can use unicode filenames in the test
export LC_ALL=en_US.UTF-8
THISDIR=`dirname $0`
export PYTHONPATH=${THISDIR}/..

echo "python3.0"
python3 ${THISDIR}/test.py
