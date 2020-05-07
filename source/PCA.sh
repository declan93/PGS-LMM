#!/bin/sh 
#SBATCH --job-name="PCA"
#SBATCH --output=logs/PCA.out
# #SBATCH -p highmem
#SBATCH -n 16
#SBATCH -N 1
source "${PWD}/config.txt"

cat ${GT}/pruned_1.fam > ${GT}/plink.fam

for chr in {1..22} X Y; do cat ${GT}/pruned_${chr}.bim; done > ${GT}/plink.bim

(echo -en "\x6C\x1B\x01"; for chr in {1..22} X Y; do tail -c +4 ${GT}/pruned_${chr}.bed; done) > ${GT}/plink.bed

# pca 
${PLINK2} --threads 32 --bfile ${GT}/plink --pca approx --out ${GT}/pca

# FastGWA input files
for i in {1..22}; do 
	echo "${GT}/${NAME}_${i}" >> ${GT}/fastGWASfiles;
done

