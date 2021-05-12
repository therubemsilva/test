#!/bin/bash

find . -name "*_rec.pdb" | while read -r arqRec; do
	dir=`echo "$arqRec" | cut -d'/' -f1,2,3`

	wget -P $dir http://www.fos.su.se/~sasha/SLipids/Downloads_files/POPC_303K.gro
done

