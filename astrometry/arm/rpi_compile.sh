#! /bin/bash

# set environment variables:
export PATH=${PATH}:/usr/local/astrometry/bin
export CC=/usr/bin/gcc-4.4

# clone the repo:
git clone https://github.com/dstndstn/astrometry.net.git
cd astrometry.net

# compile
make -j
make -j extra
make -j py
make install
