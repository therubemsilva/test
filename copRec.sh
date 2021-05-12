#!/bin/bash

for arqRec in ../comp/pdb/pdb_align/rec_pdb_align/*.pdb; do
	arqCut=`echo $arqRec | cut -d'/' -f6`
	dirRec=`echo $arqCut | cut -d'_' -f1,2,4`
	#echo $dirRec
	#echo $arqCut
	cp $arqRec ${dirRec}/coord
done
