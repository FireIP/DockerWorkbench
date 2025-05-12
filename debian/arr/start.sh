#!/bin/bash
tor &
PID1=$!
/home/container/opt/Lidarr/Lidarr -nobrowser -data=/home/container/var/lib/lidarr &
PID2=$!
/home/container/opt/Prowlarr/Prowlarr -nobrowser -data=/home/container/var/lib/prowlarr &
PID3=$!
/home/container/opt/Radarr/Radarr -nobrowser -data=/home/container/var/lib/radarr &
PID4=$!
/home/container/opt/Readarr/Readarr -nobrowser -data=/home/container/var/lib/readarr &
PID5=$!
/home/container/opt/Sonarr/Sonarr -nobrowser -data=/home/container/var/lib/sonarr &
PID6=$!

echo "Arr!"
qbittorrent-nox --webui-port=9898 &
echo "Download!"

trap "echo 'Stopping...'; kill $PID1 $PID2 $PID3 $PID4 $PID5 $PID6; exit" SIGINT SIGTERM
echo "Started"
# Keep container alive
wait
