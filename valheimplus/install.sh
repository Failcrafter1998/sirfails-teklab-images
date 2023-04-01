#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir valheimplusdedi
chmod 770 start.sh; mv start.sh ./valheimplusdedi
chmod 770 installer.sh;./installer.sh steam 896660 valheimplusdedi
LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/Grantapher/ValheimPlus/releases/latest")
URL=$(echo "$LATEST_RELEASE" | jq -r '.assets[] | select(.name=="UnixServer.tar.gz") | .browser_download_url')
wget "$URL"
mv UnixServer.tar.gz ./valheimplusdedi;tar -xf ./valheimplusdedi/UnixServer.tar.gz -C ./valheimplusdedi
rm ./valheimplusdedi/start_server_bepinex.sh
rm ./valheimplusdedi/start_game_bepinex.sh
rm -r ./valheimplusdedi/docker/
rm ./valheimplusdedi/start_server.sh
rm ./valheimplusdedi/start_server_xterm.sh
rm ./valheimplusdedi/docker_start_server.sh
rm ./valheimplusdedi/UnixServer.tar.gz
