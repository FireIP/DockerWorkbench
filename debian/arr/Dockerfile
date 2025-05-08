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
RUN         useradd -m -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

USER        root

RUN curl -o servarr-install-script.sh https://raw.githubusercontent.com/Servarr/Wiki/master/servarr/servarr-install-script.sh
RUN chmod +x servarr-install-script.sh

COPY        --chown=root:root ./unattended-servarr.sh /home/container/unattended-servarr.sh
RUN         chmod +x /home/container/unattended-servarr.sh
RUN         ./unattended-servarr.sh -l -p -r -d
RUN         rm ./unattended-servarr.sh

RUN curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/v5-develop/distribution/debian/install.sh
RUN chmod +x install-sonarr.sh
RUN ./install-sonarr.sh -u --user container --group container
RUN rm install-sonarr.sh
RUN rm *tar.gz

RUN apt autoremove -y && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

##USER       container

EXPOSE      8686 9696 7878 8787 8989

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

COPY        --chown=root:root ./start.sh /start.sh
RUN         chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]