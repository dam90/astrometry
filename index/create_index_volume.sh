#! /bin/bash
# Create a docker volume named "astrometery_index":
docker volume create astrometry_index
# Add download index files to the docker volume:
docker run --rm -v astrometry_index:/usr/local/astrometry/data dm90/astrometry download_index_files.sh
