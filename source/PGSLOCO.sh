#!/bin/sh 
#SBATCH --job-name="PGS"
#SBATCH --output=logs/PGSLOCO_%A_%a.out
#SBATCH --array=1-22
#SBATCH -n 4
#SBATCH -N 1
# #SBATCH -p highmem
source "${PWD}/config.txt"

# Generate LOCO PGS scores
${PRSice} --thread 8 --base ${results}/prsStat_${SLURM_ARRAY_TASK_ID}.gz --chr CHR --A1 A1 --A2 A2 --stat BETA --snp SNP --bp POS --pvalue P --target ${GT}/${NAME}_# --pheno-file ${PHENO} --all-score --fastscore --bar-levels 5e-05 --pheno-col ${TRAIT} --score avg --out ${PGS}/PGS.${SLURM_ARRAY_TASK_ID} --clump-p 5e-05

# LDpred code for prediction
# Rscript LDpred2.R BMI Pheno.loco.sumstats.${SLURM_ARRAY_TASK_ID}.gz ${SLURM_ARRAY_TASK_ID}
