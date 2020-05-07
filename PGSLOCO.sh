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

# SBayes code for prediction
#gctb --sbayes R --ldm LD/ukb_50k_bigset_2.8M/ukb50k_shrunk_chr${SLURM_ARRAY_TASK_ID}_mafpt01.ldm.sparse --pi 0.95,0.02,0.02,0.01 --gamma 0.0,0.0001,0.001,1 --gwas-summary ${results}/SBAYES.ma --chain-length 10000 --burn-in 2000 --out-freq 10 --out ${PGS}/SBayesR_${SLURM_ARRAY_TASK_ID} --unscale-genotype --exclude-mhc
