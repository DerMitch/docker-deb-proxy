docker-deb-proxy
================

squid-deb-proxy preconfigured in a container - for faster updates and container builds

****************
Work in progress
****************

# Build container

There is a automated build available at the [Docker Hub](). You can build it yourself if you want to change settings like the max cache size (defaults to 4000 MB).

```bash
docker build -t dermitch/deb-proxy .
```

# Run container

You should use a volume to keep downloaded packages between container restarts. The maximum size for the cache directory is about 4000 MB.

```bash
# Run squid on localhost:8080
docker run -d --name deb-proxy -p 80:8080 -v /var/cache:/cache dermitch/deb-proxy
``

# Use with Dockerfiles

Add the following line to your dockerfile to accelerate all package downloads:

```
RUN echo 'Acquire::http::Proxy "http://container:ip/";' > /etc/apt/apt.conf.d/01proxy
RUN echo 'Acquire::http::Proxy "http://192.168.59.103:8080/";' > /etc/apt/apt.conf.d/01proxy
```

**Hint:** If you want to use apt after the build process, you should make sure your proxy is always accessible or remove the created file.
