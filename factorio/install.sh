#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir factoriodedi
chmod 770 start.sh; mv start.sh ./factoriodedi
chmod 770 installer.sh;./installer.sh factorio
mv factiorioserver.tar.xz ./factoriodedi;tar -xf ./factoriodedi/factiorioserver.tar.xz -C ./factoriodedi
rm factiorioserver.tar.xz
mkdir ./factoriodedi/configs
