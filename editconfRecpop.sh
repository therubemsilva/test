#!/bin/bash

find . -name "*_popc_box.pdb" | while read -r arqRec; do

#FORMAT NAME
cutName=`echo "$arqRec" | cut -d'.' -f2`
dirCam=`echo $arqRec | cut -d'/' -f1,2,3`


#BOX
getBoxX=`tail -1 $dirCam/POPC_303K_whole.gro | awk '{print $1}'`
getBoxY=`tail -1 $dirCam/POPC_303K_whole.gro | awk '{print $2}'`
getBoxZ=`tail -1 $dirCam/POPC_303K_whole.gro | awk '{print $3+2}'` #Alter axis z

#echo $getBoxX
#echo $getBoxY
#echo $getBoxZ
#echo ''

#CENTER
valCentX=`echo $getBoxX | awk '{print $1/2}'`
valCentY=`echo $getBoxY | awk '{print $1/2}'`
valCentZ=`echo $getBoxZ | awk '{print ($1/2)+1}'` #Alter Z

#echo $valCentX
#echo $valCentY
#echo $valCentZ
#echo ''
#echo ${cutName}.gro
gmx editconf -f $arqRec -o .${cutName}.gro -center ${valCentX} ${valCentY} ${valCentZ} -box ${getBoxX} ${getBoxY} ${getBoxZ}

done

