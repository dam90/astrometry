#! /bin/bash
#
# Install dpendencies required to build and install astrometry.net on centos7 docker image

# add epel:
yum -y install epel-release

# update:
yum update -y

# for installation and debugging:
yum install -y git \
               gcc \
               make \
               python-pip \
               nano

# update pip...
pip install --upgrade pip

# add basic utilities to centos image that would normally come by default:
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
               python-devel \
               python \
               swig.x86_64

# install latest cfitsio
CFITS_URL=http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio_latest.tar.gz
curl -L  $CFITS_URL > cfitsio.tar.gz
tar zxvf cfitsio*.tar.gz
cd cfitsio
./configure --prefix=/usr
make -j
make install
ln -s /usr/lib/pkgconfig/cfitsio.pc /usr/lib64/pkgconfig/cfitsio.pc
cd ..
rm -rf cfitsio/
rm -f cfitsio.tar.gz

# python:
pip install fitsio astropy

# get NOVA dependencies:
yum install -y subversion tkinter

# install NOVA python dependencies:
echo yes | pip install numpy

echo yes | pip install setuptools\
                      wheel \
                      fitsio \
                      "django==1.7" \
                      python-openid \
                      django-openid-auth \
                      South Pillow \
                      simplejson \
                      social-auth-core \
                      matplotlib \
                      social-auth-app-django \
                      numpy \
                      astropy \
                      gunicorn
