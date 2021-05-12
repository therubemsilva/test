#!/bin/bash

: '
find . -name "*_rec.pdb" | while read -r arqRec; do
	gmxF=`echo "$arqRec" | cut -d'/' -f1,2`
	
	cp gmembed.dat $gmxF/mdp/gmembed.dat
	cp gmembed.mdp $gmxF/mdp/gmembed.mdp
done
'

find . -name "*_popc_sol.gro" | while read -r arqRec; do

	nameMembed=`echo "$arqRec" | cut -d'/' -f1,2`
	dirCoord=`echo "$arqRec" | cut -d'/' -f1,2,3`
	nameBase=`echo "$arqRec" | cut -d'/' -f1,2,3,4 | cut -d'.' -f2`
	cutName=`echo "$nameBase" | cut -d'/' -f2 | cut -d'_' -f1,3`

	#echo $arqRec			#./nlx_clu02_suf/coord/nlx_clu02_suf_popc_sol.gro
	#echo .${nameBase}		#./nlx_clu02_suf/coord/nlx_clu02_suf_popc_sol
	#echo $dirCoord			#./nlx_clu02_suf/coord
	#echo $nameMembed		#./nlx_clu02_suf
	#echo $cutName			#nlx_oxy
	#echo ''

echo ${nameMembed}/md/b4membed.tpr


gmx grompp -f ${nameMembed}/mdp/gmembed.mdp -c ${arqRec} -p ${nameMembed}/top/system_${cutName}.top -o ${nameMembed}/md/b4membed.tpr -maxwarn 2

gmx trjconv -f ${arqRec} -o ${dirCoord}/b4membed.gro -s ${nameMembed}/md/b4membed.tpr -ur compact -pbc mol<<EOF
0
EOF

gmx make_ndx -f ${arqRec} -o .${nameBase}_membed.ndx<<EOF
name 13 POPC
q
EOF

gmx grompp -f ${nameMembed}/mdp/gmembed.mdp -c ${dirCoord}/b4membed.gro -o ${nameMembed}/md/membed.tpr -maxwarn 2 -n .${nameBase}_membed.ndx -p ${nameMembed}/top/system_${cutName}.top -v

gmx mdrun -nt 1 -s ${nameMembed}/md/membed.tpr -membed ${nameMembed}/mdp/gmembed.dat -c .${nameBase}_membed.gro -mn .${nameBase}_membed.ndx -v <<EOF
1
13
EOF

done

