#!/bin/sh 
#SBATCH --job-name="GCTAgrm"
#SBATCH --output=logs/GCTAgrm_%a.out
#SBATCH -a 1-250
#SBATCH -n 4
#SBATCH -N 1
source "${PWD}/config.txt"

## CMD here
${GCTA} --bfile ${GT}/plink --make-grm-part 250 ${SLURM_ARRAY_TASK_ID} --thread-num 8 --out ${grm}/grm_prt

