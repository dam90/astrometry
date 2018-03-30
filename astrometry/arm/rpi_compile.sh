#! /bin/bash

# set environment variables:
# export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib64/pkgconfig
# export LD_LIBRARY_PATH=/user/lib64:/usr/lib
export PATH=${PATH}:/usr/local/astrometry/bin
export CC=/usr/bin/gcc-4.4

# clone the repo:
git clone https://github.com/dstndstn/astrometry.net.git
cd astrometry.net

# compile/install:
make
make extra
make py
make install
