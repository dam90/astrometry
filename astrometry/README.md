# Installing Astrometry.net
This stuff installs the astrometry.net code on top of a properly configured CentOS 7 docker image (see [base](../base)).

## NETPBM
If you read stuff, you know NETPBM needs some configuring for CentOS builds.  The compile script ([compile_astrometry.sh](./compile_astrometry.sh)) accomplishes this using [sed](http://www.pement.org/sed/) to modify `makefile.netpbm`.
