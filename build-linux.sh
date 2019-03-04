#!/bin/bash
set -e -x

apt-get update && apt-get install -y build-essential zlib1g-dev

cd /app

MUPDF='https://mupdf.com/downloads/archive/mupdf-1.14.0-source.tar.gz'

[ -d mupdf ] && rm -r mupdf

mkdir mupdf
wget -q $MUPDF -O - | tar zx -C mupdf --strip-components=1

cp fitz/_mupdf_config.h mupdf/include/mupdf/fitz/config.h
cp fitz/_pdf-device.c mupdf/source/pdf/pdf-device.c
cp fitz/_error.c mupdf/source/fitz/error.c

cd mupdf
make HAVE_X11=no HAVE_GLFW=no HAVE_GLUT=no XCFLAGS="-fPIC -std=gnu99" prefix=/usr/local install
cd ..

pip install wheel
python setup.py bdist_wheel
