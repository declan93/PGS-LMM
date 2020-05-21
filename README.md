# PGS-LMM

We have found that including the polyenic score (PGS), calculated on a leave-one-chromosome-out (LOCO) basis, as a fixed effect significantly improves the power of GWAS. The scripts here are intended to facilitate the calculation of the LOCO PGS and its inclusion as a fixed effect in a Linear Mixed Model (LMM) implemented with fastGWA.  The pipeline is written for a HPC system running SLURM resource scheduler but can be modified easily for use with other schedulers such as `SGE`.

## Usage 
Add absolute path to software and data files to 'config.txt' as well as required variables 

`bash pipeline.sh`

This will submit the job scripts to the HPC scheduler with a previous job completion dependency for each script.

## Limitations
Currently the pipeline will generate covariate files on the fly for 10 PCs, age, sex, genotyping batch and assessment centre. Any deviation from these covariates will require the user to update the covariate generating scripts `makeCovars.sh` & `makePgsCovars.sh`. An example of how to add covariates can be found here https://github.com/declan93/PGS-LMM/wiki/Adding-Covariates#adding-new-covariates

The user can opt to use `SBayesR` instead of `PRSice` by following the instructions commented in `pipeline.sh` and editing the releavant scripts.

## Job Scripts
Brief summary of each script 

All QC thresholds are defined in `config.txt`

#### EXTRACT_QC.sh
> Extract sample set from pfile input and apply filters to create an association variant set and PCA/GRM set 
> - Minor allele frequency, Hardy-Weinberg equilibrium, Imputation quality, genotype missingness, LD-pruning

> Create LD-pruned set of variants for PCA and GRM calculation

#### PCA.sh
> Concatenate LD-pruned SNPs set into one population level dataset

> Perform PCA analysis on LD-pruned set

#### makeGRM.sh
> Make multipart genetic relationship matrix (GRM) on LD-pruned SNP set

#### makeSparseGRM.sh
> Concatenate multipart GRM 

> Create sparse GRM 

#### makeCovar.sh
> Create covariate file 

#### FastGwaFull.sh
> Run initial fastGWA analysis without PGS effect 

> Create LOCO summary statistic files

#### PGSLOCO.sh
> Run LOCO polygenic score calculation

#### makePgsCovars.sh
> Create LOCO covariates from PGS-LOCO scores

#### FastGwasPGS.sh
> Run fastGWA per chromosome with PGS-LOCO score included as fixed effect


## Dependenies 

- `plink2`
- `bgzip`
- `fastGWA`
- `PRSice2`
- `SBAYESR` **optional*
