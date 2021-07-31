# lung_mnp_sarcoidosis_rnaseq

This is a public repository for the code associated to the paper: Lepzien et al 2021 Nat. Com. (doi:[10.1183/13993003.03468-2020](10.1183/13993003.03468-2020))

The folder structure used herein is divided into SCRIPTS, SUPP_FILES and ANALYSIS


The analysis done herein can be reproduced by installing `conda` and running the `run_workflow.sh` script. It will download the dataset from GEO (GSE174659), the scripts from Sauron.


1. Clone this repository
```
git clone https://github.com/czarnewski/lung_mnp_sarcoidosis_rnaseq.git
```


2. Create and activate the conda environment
```
cd lung_mnp_sarcoidosis_rnaseq

conda activate base
conda install -c conda-forge mamba

mamba env create -n Lepzien2021 -f environment_Lepzien2021.yml
conda activate Lepzien2021
```


3. Download the dataset from GEO () using the f
```
sh run_workflow.sh
```
