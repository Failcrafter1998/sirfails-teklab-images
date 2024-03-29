#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
# Script edited by SirFail
# Website: teklab.de
#          teklab.net

VAR_A=$1
VAR_B=$2
VAR_C=$3
VAR_D=$4
VAR_E=$5

LOGFILE=$(date +"%Y-%m")
LOGDIR="logs"
DATADIR=$(pwd)
APIURL="https://factorio.com/get-download/stable/headless/linux64"

if [ ! -d $LOGDIR ]; then
    mkdir $LOGDIR
    chmod 755 $LOGDIR  
    echo "$(date) - INFO: The logs folder has just been created!" >> $LOGDIR/$LOGFILE-update.log
fi

if [ ! -f version.tek ]; then
    echo "0" > version.tek   
    echo "$(date) - INFO: File version.tek has just been created!" >> $LOGDIR/$LOGFILE-update.log
fi


if [ "$VAR_A" == "file" ]; then
    wget $VAR_B/$VAR_C.tar
    if [ -f $VAR_C.tar ]; then
        tar -xf $VAR_C.tar
        rm -r $VAR_C.tar
	echo "$(date) - INFO: The file has been downloaded and extracted!" >> $LOGDIR/$LOGFILE-update.log
    else
	echo "$(date) - ERROR: The file could not be downloaded!" >> $LOGDIR/$LOGFILE-update.log    	
    fi
fi

if [ "$VAR_A" == "steam" ]; then
    wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
    if [ true ]; then
        tar -xzf steamcmd_linux.tar.gz
        chmod 777 steamcmd.sh
        chmod -R 777 linux32
        if [ "$VAR_D" != "" ] && [ "$VAR_E" != "" ]; then
	    ./steamcmd.sh +login "$VAR_D" "$VAR_E" +force_install_dir ./$VAR_C +app_update $VAR_B validate +exit
        else
            ./steamcmd.sh +login anonymous +force_install_dir ./$VAR_C +app_update $VAR_B validate +exit
        fi
        rm steamcmd_linux.tar.gz
        rm steamcmd.sh
	echo "$(date) - INFO: The file has been downloaded and extracted!" >> $LOGDIR/$LOGFILE-update.log
    else
	echo "$(date) - ERROR: The file could not be downloaded!" >> $LOGDIR/$LOGFILE-update.log
    fi
fi

if [ "$VAR_A" == "www" ]; then
    if [ -d "update_www/$VAR_B" ]; then
        $DATADIR/update_www/$VAR_B/updater.sh $DATADIR
	cd $DATADIR
    fi
fi

if [ "$VAR_A" == "factorio" ]; then
    wget -O factiorioserver.tar.xz $APIURL

    if [ $? -eq 0 ]; then
    echo "$(date) - INFO: The file has been downloaded and extracted!" >> $LOGDIR/$LOGFILE-update.log
    else
    echo "$(date) - ERROR: The file could not be downloaded!" >> $LOGDIR/$LOGFILE-update.log
    fi
fi

rm installer.sh

exit 0