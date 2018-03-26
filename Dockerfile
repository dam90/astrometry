FROM centos:latest

# add install scripts to install directory:
COPY ./astrometry /install/astrometry
COPY ./nova /install/nova
COPY ./base/install_dependencies.sh /install/

# work from root directory:
WORKDIR /

# add/configure astrometry.net dependencies:
RUN ["/install/install_dependencies.sh"]

# build astrometry:
RUN ["/install/astrometry/compile_astrometry.sh"]

# add astrometry.net to path:
ENV PATH="/usr/local/astrometry/bin:${PATH}"
ENV PYTHONPATH="/astrometry.net"

# configure nova:
WORKDIR /install/nova
RUN ["./install_nova.sh"]

# back to root directory:
WORKDIR /

# get rid of installation files:
RUN ["rm","-rf","install/"]

# add startup scripts after install (faster docker builds...)
COPY ./nova/start_nova.sh /astrometry.net/net/
COPY ./nova/solve_script.sh /astrometry.net/net/
COPY ./docker-entrypoint.sh /

# add any example index files:
COPY ./index/*.fits /usr/local/astrometry/data

# specify entrypoint
WORKDIR /
ENTRYPOINT ["./docker-entrypoint.sh"]

# start nova by default
CMD ["nova"]
