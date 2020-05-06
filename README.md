# PGS-LMM

Code for implementing the PGS-LMM method defined in *Publication* 

Edit the config file to set paths to the required files and software. 

Pipeline depends on `plink2`,`bgzip`,`fastGWA` & `PRSice2` and is written for a HPC system running SLURM.

Currently pipeline will generate LOCO covariate files on the fly for 10 PCS, age, sex, batch and centre. Any deviation from these covariates will require the user change the covariate generating scripts `makeCovars.sh` & `makePgsCovars.sh` 

The user can opt to use `SBayesR` instead of `PRSice` by following the instructions in `pipeline.sh`
