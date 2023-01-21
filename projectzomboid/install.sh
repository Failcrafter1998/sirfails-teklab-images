mkdir pzserver
chmod 770 start.sh; mv start.sh ./pzserver
chmod 770 installer.sh;./installer.sh steam 380870 pzserver
rm ./pzserver/start-server.sh