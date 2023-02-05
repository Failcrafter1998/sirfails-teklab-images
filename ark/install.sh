#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

mkdir arkdedi
chmod 770 start.sh; mv start.sh ./arkdedi
chmod 770 installer.sh;./installer.sh steam 376030 arkdedi
mkdir maplist
echo > maplist/TheIsland.bsp
echo > maplist/TheCenter.bsp
echo > maplist/ScorchedEarth_P.bsp
echo > maplist/Ragnarok.bsp
echo > maplist/Aberration_P.bsp
echo > maplist/Extinction.bsp
echo > maplist/Valguero_P.bsp
echo > maplist/Genesis.bsp
echo > maplist/CrystalIsles.bsp
echo > maplist/Gen2.bsp
echo > maplist/LostIsland.bsp
echo > maplist/Fjordur.bsp