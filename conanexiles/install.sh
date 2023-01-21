#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail


mkdir conandedi
chmod 770 start.sh; mv start.sh ./conandedi
chmod 770 installer.sh;./installer.sh steam 443030 conandedi
rm conandedi/ConanSandbox/Saved/CheckGameDB.bat
rm conandedi/ConanSandbox/Saved/ServerCleanup.bat
rm conandedi/StartServer.bat