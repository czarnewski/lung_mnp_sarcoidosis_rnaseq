#! /bin/bash -l


########################
### DEFINE VARIABLES ###
########################
main=$(pwd)
cd $main
echo $main


##################################
### ACTIVATE CONDA ENVIRONMENT ###
##################################
eval "$(conda shell.bash hook)"
# conda activate base
# conda install -c conda-forge mamba
# mamba env create -n Lepzien2021 -f environment_Lepzien2021.yml
# conda activate Lepzien2021



##############################
### DOWNLOAD DATA FROM GEO ###
##############################
mkdir $main/DATA
cd $main/DATA

#Download metadata file
curl -o GSE174659_Raw_counts.csv.gz 'https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174659/suppl/GSE174659%5FRaw%5Fcounts%2Ecsv%2Egz'
gunzip GSE174659_Raw_counts.csv.gz

#Download raw data from GEO
curl -o GSE174659_phenoData.csv.gz 'https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174659/suppl/GSE174659%5FphenoData%2Ecsv%2Egz'
gunzip GSE174659_phenoData.csv.gz

cd ..




####################
### RUN ANALYSIS ###
####################
mkdir $main/ANALYSIS
cd $main/

# Runs the overall analysis on all samples, run QC and batch correction
Rscript -e 'rmarkdown::render("SCRIPTS/1.overall_comparisons.Rmd")'

# Compares samples from different patient groups and cell types across tissues
Rscript -e 'rmarkdown::render("SCRIPTS/2.Pair-wise_comparisons_BAL_sv_Blood.Rmd")'

# Compares samples from different tissues and cell types across patient groups
Rscript -e 'rmarkdown::render("SCRIPTS/3.Pair-wise_comparisons_SP_vs_HC.Rmd")'

# Rscript -e 'rmarkdown::render("SCRIPTS/4.Nested_comparisons_SP_vs_HC_.Rmd")'
