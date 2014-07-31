#
# Dockerfile for build a squid-deb-proxy inside a container
#
# Start:
# docker run -d --name deb-proxy -v /var/cache:/cache dermitch/deb-proxy
#

FROM ubuntu:14.04
MAINTAINER Michael Mayr <michael@dermitch.de>

ENV DEBIAN_FRONTEND noninteractive
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup; \
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache; \
    apt-get update;

RUN apt-get install squid-deb-proxy

# Configuration
# 4000 MB should be enough for a lot of packages
# @todo disable: cache_access_log cache_log cache_store_log
RUN install --user=proxy --group=proxy -d /cache \
	sed -i 's/http_port 8000/http_port 80/' /etc/squid-deb-proxy/squid-deb-proxy.conf \
	sed -i 's/cache_dir aufs \/var\/cache\/squid-deb-proxy 40000 16 256/cache_dir aufs \/cache 4000 16 256/' /etc/squid-deb-proxy/squid-deb-proxy.conf \
	echo "get.docker.io" >> /etc/squid-deb-proxy/mirror-dstdomain.acl.d/10-default \
	echo "ppa.launchpad.net" >> /etc/squid-deb-proxy/mirror-dstdomain.acl.d/10-default

# @todo Find executable
# @todo Test

EXPOSE 80

VOLUME "/cache"
CMD ["", "", ""]
