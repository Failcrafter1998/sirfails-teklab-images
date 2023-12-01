#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
# Edited by SirFail
# Website: teklab.de
#          teklab.net

VAR_A=$1
VAR_B=$2
VAR_C=$3
VAR_D=$4
VAR_E=$5
VAR_F=$6
VAR_G=$7

DATADIR=$(pwd)



if [ "$VAR_A" = "factorio" ]; then
    # ./start.sh valheim gsport gspasswd

    

    ./factorio/bin/x64/factorio
fi

exit 0