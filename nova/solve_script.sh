#! /bin/bash

set -e

jobid=$1
axyfile=$2

BACKEND="astrometry-engine"

$BACKEND -v $axyfile
