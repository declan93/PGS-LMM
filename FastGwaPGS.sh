#!/bin/sh 
#SBATCH --job-name="2FASTGWA"
#SBATCH --output=logs/2FASTGWA_%A_%a.out
#SBATCH --array=1-22
#SBATCH -n 32 
#SBATCH -N 1
#SBATCH -p highmem

source "${PWD}/config.txt"

${GCTA} --bfile ${GT}/${NAME}_${SLURM_ARRAY_TASK_ID} --grm-sparse ${grm}/sp_grm --fastGWA-mlm --pheno ${PHENO} --qcovar ${traits}/qcovars_${SLURM_ARRAY_TASK_ID} --covar ${traits}/fixed.txt --threads 32 --out ${results}/PGS_adj_lmm.${TRAIT}.${SLURM_ARRAY_TASK_ID}


