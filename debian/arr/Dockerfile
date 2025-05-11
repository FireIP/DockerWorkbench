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
    libicu-dev \
    tor \
    proxychains

RUN echo "strict_chain\nproxy_dns\n[ProxyList]\nsocks5 127.0.0.1 9050" > /etc/proxychains.conf
    
RUN apt autoremove -y && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

## Setup user and working directory
RUN         useradd -u 999 -m -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

ENV HTTP_PROXY=socks5h://127.0.0.1:9050
ENV HTTPS_PROXY=socks5h://127.0.0.1:9050
ENV ALL_PROXY=socks5h://127.0.0.1:9050

USER        root

COPY        --chown=root:root ./unattended-servarr.sh /home/container/script/unattended-servarr.sh

## RUN chown -R 999:999 /opt/Lidarr /opt/Prowlarr /opt/Radarr /opt/Readarr /opt/Sonarr /var/lib/lidarr /var/lib/prowlarr /var/lib/radarr /var/lib/readarr /var/lib/sonarr

## USER       container

EXPOSE      8686 9696 7878 8787 8989

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

COPY        --chown=container:container ./start.sh /start.sh
RUN         chmod +x /start.sh

CMD ["/bin/bash", "/entrypoint.sh"]