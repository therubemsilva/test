#!/bin/bash

find . -name "*_rec.pdb" | while read -r arqRec; do
	gmxF=`echo "$arqRec"`
	gmxProc=`echo "$arqRec" | cut -d'/' -f1,2`
	gmxO=`echo "$arqRec" | cut -d'/' -f4 | cut -d'.' -f1 | cut -d'_' -f1,2,4,5`

	echo 6 | gmx pdb2gmx -f $gmxF -merge all -o ${gmxProc}/coord/${gmxO} -p ${gmxProc}/top/topol.top -i ${gmxProc}/top/posre -ignh -ter  -water tip3p
done

