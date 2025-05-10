#!/bin/bash
systemctl start lidarr &
systemctl start prowlarr &
systemctl start radarr &
systemctl start readarr &
systemctl start sonarr &

wait

echo "Arr!"

## su -c 'bash' container