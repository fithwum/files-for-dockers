#!/bin/bash
# Copyright (c) 2018 fithwum
# All rights reserved

wget https://www.teamspeak.com/versions/server.json /mnt/user/Sync/test/server.json
TEXT="Getting latest teamspeak server version."
TS_VERSION="${TS_VERSION_CHECK}"
TS_VERSION_CHECK=jq .linux.x86.version server.json
sleep 1
echo "${TEXT}"
wget https://files.teamspeak-services.com/releases/server/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 -O /mnt/user/Sync/test/ts3server_${TS_VERSION}.tar.bz2
sleep 1
exit
