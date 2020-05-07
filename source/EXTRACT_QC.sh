#!/bin/sh 
#SBATCH --job-name="Extract_Samples"
#SBATCH --output=logs/Extract_%A_%a.out
#SBATCH --array=1-22
#SBATCH -n 8
#SBATCH -N 1
source "${PWD}/config.txt"

# Extract samples to be included analysis from original UKB genotypes
"$PLINK2" --threads 8 --pfile ${GT_DIR}/${SLURM_ARRAY_TASK_ID} --mach-r2-filter ${INFO} --keep ${SAMP} --maf ${MAF} --geno ${GENO} --hwe ${HWE} midp --indep-pairwise ${WIND} ${SHIF} ${LD} --rm-dup exclude-all list --make-bed --out ${GT}/${NAME}_${SLURM_ARRAY_TASK_ID}

# LD prune and provide stricter filters for GRM variants
"$PLINK2" --threads 8 --bfile ${GT}/${NAME}_${SLURM_ARRAY_TASK_ID} --maf ${MAFp} --hwe ${HWEp} midp --extract ${GT}/${NAME}_${SLURM_ARRAY_TASK_ID}.prune.in --make-bed --out ${GT}/pruned_${SLURM_ARRAY_TASK_ID}



