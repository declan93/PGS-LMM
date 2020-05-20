# PGS-LMM

Example pipeline for implementing the PGS-LMM method defined in *** 

This pipeline is written for a HPC system running SLURM resource scheduler.

The pipeline assumes the starting point is the genotype data in pfile format. The samples with trait values of interest are extracted and QC'd from this initial starting point. 

## Usage 
Add absolute path to software and data files to 'config.txt' as well as required variables 

`bash pipeline.sh`

This will submit the job scripts to the HPC scheduler with a previous job completion dependency for each script.

Currently the pipeline will generate LOCO covariate files on the fly for 10 PCS, age, sex, batch and centre. Any deviation from these covariates will require the user change the covariate generating scripts `makeCovars.sh` & `makePgsCovars.sh` 

## Dependenies 

- `plink2`
- `bgzip`
- `fastGWA`
- `PRSice2`
- `SBAYESR` **optional*

The user can opt to use `SBayesR` instead of `PRSice` by following the instructions in `pipeline.sh` and editing the releavant scripts
