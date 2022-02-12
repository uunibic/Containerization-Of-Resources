FROM alpine

RUN addgroup -S sentinels && adduser -S unibic -G sentinels

CMD ["/bin/sh"]

ENV RELEASE_VERSION=1.0.4 SHELL=/bin/bash

RUN apk add --no-cache --update bash g++ make curl \
 && curl -o /tmp/stress-${RELEASE_VERSION}.tgz -L https://fossies.org/linux/privat/stress-${RELEASE_VERSION}.tar.gz \
 && cd /tmp \
 && tar -xzvf stress-${RELEASE_VERSION}.tgz \
 && rm /tmp/stress-${RELEASE_VERSION}.tgz \
 && cd /tmp/stress-${RELEASE_VERSION} \
 && ./configure \
 && make -j$(getconf _NPROCESSORS_ONLN) \
 && make install \
 && apk del g++ make curl \
 && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

USER unibic
CMD ["/usr/local/bin/unibic"]
