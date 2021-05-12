#!/bin/bash

find . -name "*.top" | while read -r arqRec; do
	topol=`echo "$arqRec"`			#caminho
	nameDir=`echo "$arqRec" | cut -d'/' -f1,2`	#diretorio
	nameBase=`echo "$nameDir" | cut -d'_' -f1 | cut -d'/' -f2` #formate name
	nameLig=`echo "$nameDir" | cut -d'_' -f3` #name ligand

	cp $topol ${nameDir}/top/${nameBase}_${nameLig}_rec.itp
	
	var1=`grep -n "../top/posre.itp" ${nameDir}/top/${nameBase}_${nameLig}_rec.itp | cut -d ':' -f1 | awk '{print $1+2}'`
  	var2=`grep -n 'Protein_chain_A     1' ${nameDir}/top/${nameBase}_${nameLig}_rec.itp | cut -d ':' -f1 | awk '{print $1}'`
	sed -i "$var1,${var2}d" ${nameDir}/top/${nameBase}_${nameLig}_rec.itp
	
	var0=`grep -n '#include "amber99sb-ildn.ff/forcefield.itp"' ${nameDir}/top/${nameBase}_${nameLig}_rec.itp | cut -d ':' -f1 | awk '{print $1}'` 	
	sed -i "1,${var0}d" ${nameDir}/top/${nameBase}_${nameLig}_rec.itp 	

echo '#include "../../amber99sb-ildn_edit.ff/forcefield.itp"
#include "'${nameLig}.prm'"
#include "'${nameBase}_${nameLig}_rec.itp'"
#include "'${nameLig}.itp'"
#include "../../SLipids_2016/itp_files/POPC.itp"

[ system ]
; Name
'${nameBase}_${nameLig}'

[ molecules ]
;Compound       Mols
Protein_chain_A 1' > ${nameDir}/top/system_${nameBase}_${nameLig}.top

echo '#include "../../amber99sb-ildn_edit.ff/forcefield.itp"
#include "../../SLipids_2016/itp_files/POPC.itp"
#include "../../SLipids_2016/itp_files/TIP3p.itp"

[ system ]
;Name
128-Lipid POPC Bilayer
 
[ molecules ]
;Compound       Mols
POPC            128
SOL           5120' > ${nameDir}/top/topol_popc.top

done
