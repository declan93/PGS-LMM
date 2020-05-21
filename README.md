# PGS-LMM
Linear mixed-models for association studies fail to account properly for off-target genetic effects. We found that inclusion of a leave-one-chromosome-out polygenic score (LOCO-PGS) as a fixed effect covariate increases statistical power in GWAS. We term this methodology PGS-LMM. 

This pipeline is written for a HPC system running SLURM resource scheduler but can be simply modified for other schedulers such as `SGE`.

The pipeline assumes the starting point is chromosome genotype data in pfile format. 

## Usage 
Add absolute path to software and data files to 'config.txt' as well as required variables 

`bash pipeline.sh`

This will submit the job scripts to the HPC scheduler with a previous job completion dependency for each script.

## Limitations
Currently the pipeline will generate LOCO covariate files on the fly for 10 PCS, age, sex, batch and centre. Any deviation from these covariates will require the user change the covariate generating scripts `makeCovars.sh` & `makePgsCovars.sh` 

The user can opt to use `SBayesR` instead of `PRSice` by following the instructions in `pipeline.sh` and editing the releavant scripts

## Job Scripts
Brief summary of each script 

All QC thresholds are defined in `config.txt`

#### EXTRACT_QC.sh
> Extract sample set from pfile input with multiple genotype filtering to create an association variant set and PCA/GRM set 
> - Minor allele frequency, Hardy-Weinberg equilibrium, Imputation quality, genotype missingness, LD-pruning

> Create LD-pruned variant set of variants for PCA and GRM calculation

#### PCA.sh
> Concatenate LD-pruned SNPs set into one population level dataset

> Perform PCA analysis on LD-pruned set

#### makeGRM.sh
> Make multipart genetic relationship matrix (GRM) on LD-pruned SNP set

#### makeSparseGRM.sh
> Concatenate multipart GRM 

> Create sparse GRM sample

#### makeCovar.sh
> Create covariate file 

#### FastGwaFull.sh
> Run initial fastGWA analysis on 

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
