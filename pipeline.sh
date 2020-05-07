#!/bin/bash

source config.txt

echo "Extracting samples and performing QC"
jid1=$(sbatch --export=ALL --parsable code/EXTRACT_QC.sh)

echo "Running PCA"
jid2=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid1" code/PCA.sh)

echo "Making GRM"
jid3=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid2" code/makeGRM.sh)

echo "Creating sparse GRM for fastGWA"
jid4=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid3" code/makeSparseGRM.sh)

echo "covar files"
jid5=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid4" -o "logs/MkCovar.out" -J "MkCovar" code/makeCovar.sh)

echo "GCTA fastGWA"
jid6=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid5" code/FastGwaFull.sh)

echo "polygenic score calculation"
# For SBayesR uncomment sbayes code in PGSLOCO.sh
jid7=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid6" code/PGSLOCO.sh)

echo "phenotype and LOCO PGS covars"
#SBayes run makeSbayesPGS.sh
#SBayes run SBayesPlink.sh jobarray
## uncomment and comment relevant lines in makePgsCovars.sh
jid8=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid7" -o "logs/MkLocoCovar.out" -J "MkLocoCovar" code/makePgsCovars.sh)

echo "FastGWAS PGS adjusted"
jid9=$(sbatch --export=ALL --parsable --dependency=afterok:"$jid8" code/FastGwaPGS.sh)


