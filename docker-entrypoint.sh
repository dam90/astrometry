#!/bin/bash
set -e
if [ "$1" = 'nova' ]; then
    echo "Starting NOVA server...."
    (cd /astrometry.net/net && ./start_nova.sh)
fi
exec "$@"
