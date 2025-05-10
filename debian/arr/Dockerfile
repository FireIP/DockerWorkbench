FROM        --platform=$TARGETOS/$TARGETARCH debian:stable-slim

LABEL       author="FireIP"

RUN apt update
RUN apt upgrade -y && apt install -y \
    sudo \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    systemctl \
    libicu-dev

## Setup user and working directory
RUN         useradd -u 999 -m -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

USER        root

RUN mkdir opt
RUN chown container:container opt
RUN mkdir -p var/lib
RUN chown -R container:container var

COPY        --chown=root:root ./unattended-servarr.sh /home/container/script/unattended-servarr.sh
RUN         chmod +x /home/container/script/unattended-servarr.sh
RUN         ./script/unattended-servarr.sh -l -p -r -d
RUN         rm ./script/unattended-servarr.sh

RUN curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/v5-develop/distribution/debian/install.sh
RUN chmod +x install-sonarr.sh
RUN ./install-sonarr.sh -u --user container --group container
RUN rm install-sonarr.sh
RUN rm *tar.gz
RUN mv /opt/Sonarr opt/Sonarr
RUN mv /var/lib/sonarr/ var/lib/sonarr/

RUN apt autoremove -y && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

## RUN chown -R 999:999 /opt/Lidarr /opt/Prowlarr /opt/Radarr /opt/Readarr /opt/Sonarr /var/lib/lidarr /var/lib/prowlarr /var/lib/radarr /var/lib/readarr /var/lib/sonarr

USER       container

EXPOSE      8686 9696 7878 8787 8989

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

COPY        --chown=container:container ./start.sh /start.sh
RUN         chmod +x /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]