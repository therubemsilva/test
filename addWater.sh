#!/bin/bash

find . -name "*_popc_box.gro" | while read -r arqRec; do
	dirBase=`echo "$arqRec" | cut -d'/' -f1,2,3`
	
	cp /usr/local/gromacs/share/gromacs/top/vdwradii.dat ${dirBase}/b_vdwradii.dat
	
	sed '/;Water charge sites/ \a
	POP  C     0.45\
	' ${dirBase}/b_vdwradii.dat > vdwradii.dat
	
	out=`echo $arqRec | cut -d'.' -f2 | cut -d'_' -f1,2,3,4,5,6`
	topol=`echo "$arqRec" | cut -d'/' -f1,2`
	topolRen=`echo "$arqRec" | cut -d'/' -f1,2 | cut -d'_' -f1,3 | cut -d'.' -f2 | cut -d'/' -f2`
	
	#echo $arqRec
	#echo .${out}_sol.gro
	#echo ${topol}/top/system_${topolRen}.top
	
	gmx solvate -cp $arqRec -cs -o .${out}_sol.gro -p ${topol}/top/system_${topolRen}.top
done

