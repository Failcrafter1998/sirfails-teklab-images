#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir rustdedi
chmod 770 start.sh; mv start.sh ./rustdedi
chmod 770 installer.sh;./installer.sh steam 258550 rustdedi
rm ./rustdedi/runds.sh