mkdir pzserver
chmod 777 start.sh; mv start.sh ./pzserver
chmod 777 installer.sh;./installer.sh steam 380870 pzserver
rm ./pzserver/start-server.sh