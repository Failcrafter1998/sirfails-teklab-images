#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
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

if [ "$VAR_A" = "pz" ]; then
    # ./start.sh pz gsram gsip gsport gsqueryport
    export PATH="${DATADIR}/jre64/bin:$PATH"
	export LD_LIBRARY_PATH="${DATADIR}/linux64:${DATADIR}/natives:${DATADIR}:${DATADIR}/jre64/lib/amd64:${LD_LIBRARY_PATH}"
	JSIG="libjsig.so"
	LD_PRELOAD="${LD_PRELOAD}:${JSIG}" ./ProjectZomboid64 -Xmx"$VAR_B"m -Xms"$VAR_B"m -Duser.home=./saves -- -ip $VAR_C -port $VAR_D -udpport $VAR_E
fi                 