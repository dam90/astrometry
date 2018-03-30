#! /bin/#!/usr/bin/env bash

# update repos:
apt-get update

# install utilities
apt-get install -y git \
                   make gcc-4.4 \
                   python-pip \
                   wget \
                   nano

# link gcc version:
ln /usr/bin/gcc-4.4 /usr/bin/gcc
export CC=/usr/bin/gcc-4.4

# upgrade pip:
pip install --upgrade pip

# since it's docker:
apt-get install file \
                lsof

# install dependencies:
apt-get install bzip2 libbz2-dev \
                libcairo2-dev \
                libjpeg-dev \
                libpng12-dev \
                libnetpbm10-dev libnetpbm10 netpbm \
                zlib1g-dev \
                wcslib-dev wcslib-tools \
                python python-numpy \
                swig3.0

# install cfitsio
apt-get install libcfitsio-dev libcfitsio-bin

# install NOVA python dependencies:
echo yes | pip install setuptools\
                       wheel \
                       fitsio \
                       "django==1.7" \
                       python-openid \
                       django-openid-auth \
                       South \
                       Pillow \
                       simplejson \
                       social-auth-core \
                       matplotlib \
                       social-auth-app-django \
                       pyfits \
                       gunicorn
