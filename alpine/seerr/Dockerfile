FROM        --platform=$TARGETOS/$TARGETARCH node:22-alpine

LABEL       author="FireIP"

RUN apk -U upgrade
RUN apk add --no-cache --update curl lsof ca-certificates openssl git tar bash sqlite fontconfig tzdata iproute2 tini zip unzip

RUN npm install -g pnpm@latest-9

RUN mkdir -p /opt/jellyseerr && cd /opt/jellyseerr

## Setup user and working directory
RUN         adduser --disabled-password -h /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

EXPOSE 5055

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

COPY        --chown=container:container ./start.sh /start.sh
RUN         chmod +x /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]