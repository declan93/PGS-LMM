#!/bin/sh 
#SBATCH --job-name="SBAYESPLINK"
#SBATCH --output=logs/PLINKSBAYES_%a.out
#SBATCH --array=1-22
#SBATCH -n 4
#SBATCH -N 1
# #SBATCH -p highmem
source "${PWD}/config.txt"

plink2 --bfile ${GT}/${NAME} --score ${PGS}/plink_${SLURM_ARRAY_TASK_ID}_run --out ${PGS}/${SLURM_ARRAY_TASK_ID}
