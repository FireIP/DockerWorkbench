#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server eg.: q2proded net_enable_ipv6 2 sv_show_name_changes 1 sys_console 2 +hostname LuckyServer +gamemap q2dm1
${MODIFIED_STARTUP}
q2proded net_enable_ipv6 2 sv_show_name_changes 1 sys_console 2 +hostname LuckyServer +gamemap q2dm1