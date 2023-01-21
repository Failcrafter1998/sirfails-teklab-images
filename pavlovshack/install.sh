#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir pavlovshack
chmod 770 start.sh; mv start.sh ./pavlovshack
chmod 770 installer.sh;./installer.sh steam 622970 pavlovshack
mkdir -p ./pavlovshack/Pavlov/Saved/maps
mkdir -p ./pavlovshack/Pavlov/Saved/Config/LinuxServer