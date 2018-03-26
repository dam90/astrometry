#! /bin/bash
# Download astrometry index files.

# download 4100 to /usr/local/astrometry/data:
wget -r -l1 -c -N --no-parent --no-host-directories --cut-dirs=2 -A ".fits" -P /usr/local/astrometry/data/ http://broiler.astrometry.net/~dstn/4100/
# download 4200 to /usr/local/astrometry/data:
wget -r -l1 -c -N --no-parent --no-host-directories --cut-dirs=2 -A ".fits" -P /usr/local/astrometry/data/ http://broiler.astrometry.net/~dstn/4200/
