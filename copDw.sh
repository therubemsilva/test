#!/bin/bash

for arqDw in ../comp/pdb/pdb_align/dow_pdb_align/rcol_dow_gro_align/name_rcol_dow_gro_aling/*.gro; do
	name=`echo $arqDw | cut -d'/' -f8 | cut -d'_' -f2,3,5`
	cp $arqDw ${name}/coord
done
