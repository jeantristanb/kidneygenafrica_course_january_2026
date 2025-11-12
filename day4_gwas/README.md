# Training exercise for GWAS

## GWAS context
# 🧬 Training Exercise for GWAS

## GWAS Context

Genome-Wide Association Studies (GWAS) are powerful research approaches used to identify genetic variants associated with specific traits or diseases.  
They involve scanning the entire genome of many individuals to detect differences in allele frequencies between affected (cases) and unaffected (controls) groups.  
These differences, often single-nucleotide polymorphisms (SNPs), can reveal genetic loci linked to disease risk, biological pathways, and potential therapeutic targets.

GWAS relies on large, well-characterized cohorts and careful data processing to ensure reliable results.  
The main steps include defining the sample, genotyping, performing rigorous quality control (QC), imputing missing genotypes, conducting association analyses, and interpreting significant results.

---

## Main Steps of a GWAS

### 1. Sample Definition and Collection
- Define clear inclusion/exclusion criteria.  
- Ensure balanced representation to avoid bias (e.g., sex, ancestry, case/control ratio).  
- Record relevant covariates (age, sex, site, lifestyle factors, etc.).

### 2. Genotyping
- Choose the appropriate genotyping platform (e.g., H3Africa array, GWAS array).  
- Consider cost, genomic coverage, and efficiency.

### 3. Quality Control (QC) of Genotypes
- Remove poorly genotyped SNPs or samples.  
- Identify potential genotyping errors or batch effects.

### 4. QC for Population Structure (Admixture)
- Assess genetic ancestry using PCA or ADMIXTURE.  
- Detect population outliers or hidden relatedness.  
- Control for population stratification in association models.

### 5. QC of Phenotypes
- Check for outliers, missing data, and phenotype consistency.  
- Verify sex and relatedness using genetic data.

### 6. Imputation
- Infer untyped variants using a reference panel (e.g., 1000 Genomes, H3Africa, TOPMed).  
- Choose reference data that best matches your population’s ancestry.

### 7. Association Analysis
- Run appropriate models (linear or logistic regression).  
- Include relevant covariates (e.g., age, sex, PCs, site).  
- Evaluate test statistics (e.g., genomic inflation factor λ).

### 8. Post-Imputation and Interpretation
- Visualize results (Manhattan and QQ plots).  
- Extract significant loci (clumping, regional plots).  
- Annotate variants (genes, biological relevance).  
- Perform fine-mapping and replication if possible.

![diagram of steps of assocation studies](images/association_diagram.jpg)

## Objective of GWAS excercice
Your collaborators Nephro Logist, had performed a studies to understandi common variant that increase kidney diseases using eGFR as markers. Nephro  sent you raw genotype data with phenotypes and told you it is feeling that some phenotype individual value look not correct. Furthermore, look some individuals had been switch during process between genotyoe and process. 
 
Objective of excercice is to quality control of phenotype, genotype, performed gwas, and extract signifc annt postiions and plot results.



