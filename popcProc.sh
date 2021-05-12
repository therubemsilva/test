#!/bin/bash

find . -name "*_303K.gro" | while read -r arqRec; do

#FORMAT NAME
popcFile=`echo "$arqRec"`
dirBase=`echo "$arqRec" | cut -d'/' -f1,2` #ex: nlx_clu02_b72
sysBase=`echo "$dirBase" | cut -d'_' -f1,2 | cut -d'.' -f2 | cut -d'/' -f2` #ex: nlx_clu02
nameLig=`echo "$dirBase" | cut -d'_' -f3 | cut -d'.' -f2` #ex: b72

#echo $popcFile
#echo $dirBase
#echo $sysBase
#echo $nameLig

#CREATE min.mdp
echo"; Lines starting with ';' ARE COMMENTS
; Everything following ';' is also comment

title		= Energy Minimization	; Title of run


; Parameters describing what to do, when to stop and what to save
define 		=  
integrator	= steep					; Algorithm (steep = steepest descent minimization)
emtol		= 1000.0			        ; Stop minimization when the maximum force < 50.0 kJ/mol
emstep		= 0.01					; Energy step size
nsteps		= 5000000					; Maximum number of (minimization) steps to perform

; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
nstlist		= 1		    ; Frequency to update the neighbor list and long range forces
ns_type		= grid		; Method to determine neighbor list (simple, grid)
rlist		= 1.2		; Cut-off for making neighbor list (short range forces)
coulombtype	= PME		; Treatment of long range electrostatic interactions
rcoulomb	= 1.2		; Short-range electrostatic cut-off
rvdw		= 1.2		; Short-range Van der Waals cut-off
pbc		= xyz 		; Periodic Boundary Condition" > $dirBase/mdp/min.mdp

#PROC POPC_303K
gmx grompp -c $popcFile -p $dirBase/top/topol_popc.top -f $dirBase/mdp/min.mdp -o $dirBase/md/min.tpr
echo 0 | gmx trjconv -s $dirBase/md/min.tpr -f $popcFile -o $dirBase/coord/POPC_303K_whole.gro -pbc mol -ur compact
gmx_d editconf -f $dirBase/coord/POPC_303K_whole.gro -o $dirBase/coord/POPC_303K_whole.pdb 

#BOX
getBoxX=`tail -1 $dirBase/coord/POPC_303K_whole.gro | awk '{print $1}'`
getBoxY=`tail -1 $dirBase/coord/POPC_303K_whole.gro | awk '{print $2}'`
getBoxZ=`tail -1 $dirBase/coord/POPC_303K_whole.gro | awk '{print $3}'`

echo $getBoxX
echo $getBoxY
echo $getBoxZ

#CENTER
valCentX=`echo $getBoxX | awk '{print $1/2}'`
valCentY=`echo $getBoxY | awk '{print $1/2}'`
valCentZ=`echo $getBoxZ | awk '{print $1/2}'`

#EDIT BOX AND CENTER - REC
# -f ex: nlx_clu02_b72_rec.gro
# -o ex: nlx_clu02_b72_rec_box.gro
gmx_d editconf -f $dirBase/coord/${sysBase}_${nameLig}_rec.gro -o $dirBase/coord/${sysBase}_${nameLig}_rec_box.pdb -box $getBoxX $getBoxY $getBoxZ -center $valCentX $valCentY $valCentZ

done

