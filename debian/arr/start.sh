#!/bin/bash
/opt/Lidarr/Lidarr -nobrowser -data=/var/lib/lidarr &
/opt/Prowlarr/Prowlarr -nobrowser -data=/var/lib/prowlarr &
/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr &
/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarr &
/opt/Sonarr/Sonarr -nobrowser -data=/var/lib/sonarr &

echo "Arr!"

# Keep container alive
tail -f /dev/null
