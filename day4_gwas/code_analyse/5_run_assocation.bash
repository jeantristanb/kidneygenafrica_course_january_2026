# we tested different models using plink2 
## no covariable
../../bin/plink2  --bfile ../Data_beforeqc/afreur --pheno  ../Data_beforeqc/afreur_pheno.tsv  --pheno-name egfr -out egfr_raw  --glm allow-no-covars --allow-no-sex   
../../bin/plink2  --bfile ../Data_beforeqc/afreur --pheno  ../Data_beforeqc/afreur_pheno.tsv  --pheno-name egfr -out egfr_covar1 --glm 'hide-covar'  --allow-no-sex  --covar-name age,Sex,Superpopulation --covar ../Data_beforeqc/afreur_pheno.tsv
../../bin/plink2  --bfile ../Data_qc/genotyped_qc  -pheno ../Data_qc/qc_pheno.tsv  --pheno-name egfr -out egfr_qc_covar1 --glm 'hide-covar'  --covar-name age,Sex,Superpopulation --covar ../Data_qc/qc_pheno.tsv

../../bin/plink2 -bfile ../Data_qc/genotyped_qc  --clump egfr_qc_covar1.egfr.glm.linear --clump-p1 5e-8 --clump-p2 0.1 --clump-r2 0.1 --clump-kb 100000

