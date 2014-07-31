#!/bin/sh
# Stripped down version of /etc/init/squid-deb-proxy.conf

. /usr/share/squid-deb-proxy/init-common.sh
pre_start

if [ -x /usr/sbin/squid ]; then
    SQUID=/usr/sbin/squid
elif  [ -x /usr/sbin/squid3 ]; then
    SQUID=/usr/sbin/squid3
else
    echo "No squid binary found"
    exit 1
fi
exec $SQUID -N -f /etc/squid-deb-proxy/squid-deb-proxy.conf

# Note we don't call the post-start function, because we don't need to support avahi
