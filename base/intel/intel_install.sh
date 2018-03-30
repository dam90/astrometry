#! /bin/bash
#
# Install dpendencies required to build and install astrometry.net on a clean CentOS 7 installation
# I'm using an official docker image, so certain linux utilities have to be added that are normally present by default.

# add epel:
yum -y install epel-release

# update:
yum update -y

# for installation and debugging:
yum install -y git \
               gcc \
               make \
               python-pip \
               wget

# upgrade pip...
pip install --upgrade pip

# linux utilities missing from docker image:
yum install -y file \
               lsof \

# install astrometry.net dependencies:
yum install -y bzip2-devel \
               cairo-devel \
               libjpeg-devel \
               libpng-devel \
               libXrender-devel \
               netpbm-devel \
               netpbm-progs \
               netpbm \
               xorg-x11-proto-devel \
               zlib-devel \
               wcslib-devel.x86_64 \
               python python-devel \
               swig.x86_64

# intall numpy here:
echo yes | pip install numpy

# install latest cfitsio
CFITS_URL=http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio_latest.tar.gz
curl -L  $CFITS_URL > cfitsio.tar.gz
tar zxvf cfitsio*.tar.gz
cd cfitsio
./configure --prefix=/usr
make
make install
ln -s /usr/lib/pkgconfig/cfitsio.pc /usr/lib64/pkgconfig/cfitsio.pc
cd ..
rm -rf cfitsio/
rm -f cfitsio.tar.gz

# python:
pip install fitsio astropy

# tkinter not present in the docker image:
yum install -y tkinter

# install NOVA python dependencies:
echo yes | pip install setuptools\
                       wheel \
                       "django==1.7" \
                       python-openid \
                       django-openid-auth \
                       South Pillow \
                       simplejson \
                       social-auth-core \
                       matplotlib \
                       social-auth-app-django \
                       gunicorn
