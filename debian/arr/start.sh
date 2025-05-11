#!/bin/bash
tor &
/home/container/opt/Lidarr/Lidarr -nobrowser -data=/home/container/var/lib/lidarr &
/home/container/opt/Prowlarr/Prowlarr -nobrowser -data=/home/container/var/lib/prowlarr &
/home/container/opt/Radarr/Radarr -nobrowser -data=/home/container/var/lib/radarr &
/home/container/opt/Readarr/Readarr -nobrowser -data=/home/container/var/lib/readarr &
/home/container/opt/Sonarr/Sonarr -nobrowser -data=/home/container/var/lib/sonarr &

echo "Arr!"

# Keep container alive
tail -f /dev/null
