find . -name "*_popc_sol_membed.gro" | while read -r arqRec; do
	dirBase=`echo "$arqRec" | cut -d'/' -f1,2,3`
	echo $dirBase

cp /usr/local/gromacs/share/gromacs/top/vdwradii.dat ${dirBase}/b_vdwradii.dat
sed '/; Water charge sites/ a\
POP  C     0.45 \
' ${dirBase}/b_vdwradii.dat > ${dirBase}/vdwradii.dat

gmx solvate -cp $arqRec -cs -o ${arqRec}_solvate.gro
rm ${dirBase}/vdwradii.dat

done
