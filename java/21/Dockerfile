FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-alpine

LABEL       author="FireIP"

RUN apk add --no-cache --update curl lsof ca-certificates openssl git tar bash sqlite fontconfig tzdata iproute2 tini zip unzip

## Setup user and working directory
RUN         adduser --disabled-password -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]