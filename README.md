# lung_mnp_sarcoidosis_rnaseq
Paulo Czarnewski, 2012.07.31
***

This is a public repository for the code associated to the paper: Lepzien et al 2021 Nat. Com. (doi:[10.1183/13993003.03468-2020](10.1183/13993003.03468-2020))

The folder structure used herein is divided into SCRIPTS, DATA, SUPP_FILES and ANALYSIS


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


3. Run the worflow analysis pipeline. It will download the dataset from GEO (GSE174659) and put them in the folder DATA. Then it will render the scripts in the SCRIPT folder in sequential order of analysis. The output of those scripts will be placed under the folder ANALYSIS.
```
sh run_workflow.sh
```
