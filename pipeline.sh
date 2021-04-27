#!/bin/bash

source config.txt

echo "Extracting samples and performing QC"
jid1=$(sbatch --export=ALL --parsable source/EXTRACT_QC.sh)

echo "Running PCA"
jid2=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid1" source/PCA.sh)

echo "Making GRM"
jid3=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid2" source/makeGRM.sh)

echo "Creating sparse GRM for fastGWA"
jid4=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid3" source/makeSparseGRM.sh)

echo "covar files"
jid5=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid4" -o "logs/MkCovar.out" -J "MkCovar" source/makeCovar.sh)

echo "GCTA fastGWA"
jid6=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid5" source/FastGwaFull.sh)

echo "polygenic score calculation"
# For LDpred2 uncomment Rscript code in PGSLOCO.sh
jid7=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid6" source/PGSLOCO.sh)

echo "phenotype and LOCO PGS covars"
## uncomment and comment relevant lines in makePgsCovars.sh for LDpred2
jid8=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid7" -o "logs/MkLocoCovar.out" -J "MkLocoCovar" source/makePgsCovars.sh)

echo "FastGWAS PGS adjusted"
jid9=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid8" source/FastGwaPGS.sh)


