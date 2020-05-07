#!/bin/sh
#SBATCH --job-name="SparseGRM"
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -p highmem
#SBATCH -o logs/SparseGRM.out

source "${PWD}/config.txt"

# concatenate GRM parts
cat ${grm}/grm_prt.part_*.grm.id > ${grm}/GRM.grm.id
cat ${grm}/grm_prt.part_*.grm.bin > ${grm}/GRM.grm.bin
cat ${grm}/grm_prt.part_*.grm.N.bin > ${grm}/GRM.grm.N.bin

# sparse GRM from SNP data
${GCTA} --grm ${grm}/GRM --make-bK-sparse 0.05 --threads 32 --out ${grm}/sp_grm


