#!/bin/bash
echo "Starting install..."
cd /home/container
mkdir opt
chown container:container opt
mkdir -p var/lib
chown -R container:container var

chmod +x /home/container/script/unattended-servarr.sh
./script/unattended-servarr.sh -l -p -r -d
rm ./script/unattended-servarr.sh

curl -o install-sonarr.sh https://raw.githubusercontent.com/Sonarr/Sonarr/v5-develop/distribution/debian/install.sh
chmod +x install-sonarr.sh
./install-sonarr.sh -u --user container --group container
rm install-sonarr.sh
rm *tar.gz
mv /opt/Sonarr opt/Sonarr
mv /var/lib/sonarr/ var/lib/sonarr/

mkdir -p /mnt/server
mv opt /mnt/server/opt
mv var /mnt/server/var

apt autoremove -y && \
apt-get clean \
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*