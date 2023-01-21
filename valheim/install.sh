#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir valheimdedi
chmod 770 start.sh; mv start.sh ./valheimdedi
chmod 770 installer.sh;./installer.sh steam 896660 valheimdedi
rm -r ./valheimdedi/docker/