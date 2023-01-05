mkdir vrisingdedi
chmod 777 start.sh; mv start.sh ./vrisingdedi
chmod 777 installer.sh;./installer.sh steam 1829350 vrisingdedi
mkdir vrisingdedi/saves
mkdir vrisingdedi/saves/Settings
rm vrisingdedi/start_server_example.bat
cp ./vrisingdedi/VRisingServer_Data/StreamingAssets/Settings/ServerGameSettings.json ./vrisingdedi/saves/Settings
cp ./vrisingdedi/VRisingServer_Data/StreamingAssets/Settings/ServerHostSettings.json ./vrisingdedi/saves/Settings