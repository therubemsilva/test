#!/bin/bash

#ALTER TOPOL
: '
find . -name "system_*_*.top" | while read -r arqRec; do
	sysTopol=`echo "$arqRec"`
	
	head -5 ${sysTopol} > ${arqRec}.tmp
	echo '#include "../../SLipids_2016/itp_files/TIP3p.itp"' >> ${arqRec}.tmp
	echo '' >> ${arqRec}.tmp
	tail -8 ${sysTopol} >> ${arqRec}.tmp

	cat ${arqRec}.tmp
	echo '------------'
	echo ''
	mv ${arqRec}.tmp ${arqRec}
done
'

#ALTER LABEL SOL
find . -name "*gro_solvate.gro" | while read -r arqRec; do
        sysTopol=`echo "$arqRec"`
	sed -i 's/ OW/OH2/g' $arqRec
	sed -i 's/HW1/ H1/g' $arqRec
	sed -i 's/HW2/ H2/g' $arqRec	
done


#ALTER TOPOL
: '
find . -name "system_*_*.top" | while read -r arqRec; do
        sysTopol=`echo "$arqRec"`

        head -14 ${sysTopol} > ${arqRec}.tmp
	echo 'POPC	128' >> ${arqRec}.tmp
	tail -1 ${sysTopol} >> ${arqRec}.tmp
	cat ${arqRec}.tmp
        echo '------------'
        echo ''
        mv ${arqRec}.tmp ${arqRec}
done
'

#ALTER TOPOL
: '
find . -name "system_*_*.top" | while read -r arqRec; do
        sysTopol=`echo "$arqRec" | cut -d'/' -f4 | cut -d'_' -f3 | cut -d'.' -f1`
        #echo $sysTopol
	sed -i 's/#include "'${sysTopol}'.prm"/;#include "'${sysTopol}'.prm"/g' $arqRec
        sed -i 's/#include "'${sysTopol}'.itp"/;#include "'${sysTopol}'.itp"/g' $arqRec
done
'

