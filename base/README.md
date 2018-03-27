# Base Image Preparation
Stuff in here is all about preparing the base CentOS system to install Atrometry.net.  The install script ([install_dependencies.sh](./install_dependencies.sh)) downloads a series of linux packages and python libraries required to successfully compile the code on CentOS 7.  It's possible that this script would properly configure a bare-metal CentOS 7 system (as opposed to a docker image) but I haven't tested that.

## Resources
I used the links below to get started.  They were no sufficient alone, but they were a good start:

* [Astrometry.Net documentation](http://astrometry.net/doc/build.html)
* [an old reddit threat](https://www.reddit.com/r/astrophotography/comments/211wcw/installing_astrometrynet_on_centos_65_x8664/)
* [plaidhat](http://plaidhat.com/code/astrometry.php)

## Quirks
Most of the initial development of this image was performed on OS X.  When I went to deploy the container to other Docker hosts running on linux (CentOS and Ubuntu) I experienced unpredictable results.  The deployment meant pushing to hub.docker.io, pulling the image to the test servers, and starting up.

I solved this by building the image on one of the linux hosts.  When built on the Docker engine running on a linux host (not Docker for mac) the build performed identically on all three host environments.  I'm no exactly sure why, but I imagine it has something to do with the virtualization used to run Docker on OS X.

I have not tested on Docker for Windows.  (gross...)

## TODO
* clean up after installation
* remove compiler mess
* attempt development on an Alpine base image
