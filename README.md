Out-of-the-box Astrometry.net for local plate solving using Docker.

## Overview

I wanted to be able to spin up a local plate solver (including web API) and with (almost) zero configuration.  In my case, I use [astrometry.net](http://astrometry.net) (ADN) to assist building mount models for my telescope, so I want to be able to stand up a new ADN server on a laptop, or perhaps a raspberry pi to give me ADN's capability without access to the interwebs.

My solution is a Docker container that is not has functioning ADN code, but by default boots a functioning ADN web server.  

* Boots a local copy of the NOVA web server by default, exposing astrometery.net with a web capability
* Can be launched with a single command:

    `docker run --name nova --restart unless-stopped -v /my/index/data:/usr/local/astrometry/data -p 8000:8000 dm90/astrometry`

    The command above starts a docker container using the `dm90/astrometry` image and:

      * `--name nova` gives the container the name "nova"

      * `--restart` unless-stopped' restarts the container after errors/reboots
