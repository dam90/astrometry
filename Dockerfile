FROM centos:latest

# ----------------------------------------------
#               BASE INSTALLATION
# ----------------------------------------------
COPY ./base /install/base
WORKDIR /install/base
RUN ["./install_dependencies.sh"]

# ----------------------------------------------
#            ASTROMETRY INSTALLATION
# ----------------------------------------------
COPY ./astrometry /install/astrometry
WORKDIR /
RUN ["/install/astrometry/compile_astrometry.sh"]
ENV PATH="/usr/local/astrometry/bin:${PATH}"
ENV PYTHONPATH="/astrometry.net"

# ----------------------------------------------
#              NOVA INSTALLATION
# ----------------------------------------------
COPY ./nova /install/nova
COPY ./nova/my_fixtures.json /astrometry.net/net/fixtures/
WORKDIR /install/nova
RUN ["./install_nova.sh"]

# ----------------------------------------------
#                   CLEAN UP
# ----------------------------------------------
WORKDIR /
RUN ["rm","-rf","install/"]

# ----------------------------------------------
#                RUNTIME STUFF
# ----------------------------------------------
# startup scripts
COPY ./nova/start_nova.sh /astrometry.net/net/
COPY ./nova/solve_script.sh /astrometry.net/net/
COPY ./docker-entrypoint.sh /
# add any example index files:
COPY ./index/*.fits /usr/local/astrometry/data/
# add utility script for downloading index files to astrometry/bin, which is part of the path:
COPY ./index/download_index_files.sh /usr/local/astrometry/bin/

# ----------------------------------------------
#                  ENTRYPOINT
# ----------------------------------------------
WORKDIR /
ENTRYPOINT ["./docker-entrypoint.sh"]
# start nova by default
CMD ["nova"]
