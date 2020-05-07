#!/bin/sh 
#SBATCH --job-name="1FastGWA"
#SBATCH --output=logs/1FASTGWA_%A.out
#SBATCH -n 32
#SBATCH -N 1
#SBATCH -p highmem
#SBATCH -x compute[04-05]
source "${PWD}/config.txt"

${GCTA} --mbfile ${GT}/fastGWASfiles  --grm-sparse ${grm}/sp_grm --fastGWA-mlm --pheno ${PHENO} --qcovar ${traits}/qcovars.txt --covar ${traits}/fixed.txt --threads 32 --out ${results}/Stats.${TRAIT}.orig

## generate sum stat files with out the chromosome in the name. These are used by PRSice to generate the PRS score
for i in {1..22}; do 
	cat ${results}/Stats.${TRAIT}.orig.fastGWA | awk -v chr="$i" '$1 != chr {print $0}' | ${BGZIP} -c > ${results}/prsStat_${i}.gz; 
done

#SBayes format
#awk '{print $2,$4,$5,$7,$8,$9,$10,$6}' ${results}/Stats.${TRAIT}.orig.fastGWA > ${results}/SBAYES.ma
