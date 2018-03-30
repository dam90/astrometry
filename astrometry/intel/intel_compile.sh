#! /bin/bash

# set environment variables:
# export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib64/pkgconfig
# export LD_LIBRARY_PATH=/user/lib64:/usr/lib
export PATH=${PATH}:/usr/local/astrometry/bin


# clone the repo:
git clone https://github.com/dstndstn/astrometry.net.git
cd astrometry.net

# Edit 'makefile.netpbm' to look like this:
# NETPBM_INC ?= -I/usr/include/netpbm
# NETPBM_LIB ?= -L/usr/lib64 -lnetpbm
cd util
ORIGINAL_LINE_START='NETPBM_INC.*'
REPLACE_WITH='NETPBM_INC ?= -I\/usr\/include\/netpbm\/'
sed -i "s/$ORIGINAL_LINE_START/$REPLACE_WITH/g" makefile.netpbm
ORIGINAL_LINE_START='NETPBM_LIB.*'
REPLACE_WITH='NETPBM_LIB ?= -L\/usr\/lib64 -lnetpbm'
sed -i "s/$ORIGINAL_LINE_START/$REPLACE_WITH/g" makefile.netpbm
cd ..

# compile/install:
make config > /install/config_results
make
make extra
make py
make install
