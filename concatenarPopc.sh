#!/bin/bash

find . -name "*_rec_box.pdb" | while read -r arqRec; do

#FORMAT NAME
recboxFile=`echo "$arqRec"`
dirBase=`echo "$arqRec" | cut -d'/' -f1,2` #ex: nlx_clu02_b72
sysBase=`echo "$dirBase" | cut -d'_' -f1,2 | cut -d'.' -f2 | cut -d'/' -f2` #ex: nlx_clu02
nameLig=`echo "$dirBase" | cut -d'_' -f3 | cut -d'.' -f2` #ex: b72

#echo ${recboxFile}
#echo ${dirBase}/coord/POPC_303K_whole.pdb
#echo ${dirBase}/coord/${sysBase}_${nameLig}_popc_box.pdb
#echo ''

#CONCAT REC E POPC
grep "ATOM" $recboxFile > ${dirBase}/coord/${sysBase}_${nameLig}_popc_box.pdb
grep "ATOM" ${dirBase}/coord/POPC_303K_whole.pdb >> ${dirBase}/coord/${sysBase}_${nameLig}_popc_box.pdb
echo "END" >> ${dirBase}/coord/${sysBase}_${nameLig}_popc_box.pdb

done


