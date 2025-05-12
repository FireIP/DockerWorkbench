#!/bin/bash
git clone https://github.com/Fallenbagel/jellyseerr.git
cd /home/container/jellyseerr
git checkout main

CYPRESS_INSTALL_BINARY=0 pnpm install --frozen-lockfile

pnpm build

mkdir -p /mnt/server
mv /home/container/jellyseerr /mnt/server/jellyseerr