FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-alpine

LABEL       author="FireIP"

RUN apk -U upgrade
RUN apk add --no-cache --update curl lsof ca-certificates openssl git tar bash sqlite fontconfig tzdata iproute2 tini zip unzip
RUN apk add --no-cache --update meson gcc linux-headers libc-dev zlib-dev

RUN git clone https://github.com/skullernet/q2pro.git
RUN cd q2pro && meson setup builddir && meson configure builddir -D anticheat-server=true && meson configure builddir && meson compile -C builddir && ninja -C builddir install

## Setup user and working directory
RUN         adduser --disabled-password -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]