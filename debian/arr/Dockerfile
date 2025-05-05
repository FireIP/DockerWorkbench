FROM        --platform=$TARGETOS/$TARGETARCH debian:stable-slim

LABEL       author="FireIP"

RUN apt update
RUN apt upgrade -y && apt install -y \
    sudo \
    curl \
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

RUN curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/v5-develop/distribution/debian/install.sh
RUN chmod +x install-sonarr.sh
RUN ./install-sonarr.sh -u --user container --group container
RUN rm install-sonarr.sh
RUN rm Sonarr*

##USER       container

EXPOSE      8989

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

CMD ["/bin/bash"]