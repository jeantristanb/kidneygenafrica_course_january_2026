# 🧬 Training Exercise: APOL1 Risk Variants and CKD Progression

## 📑 Table of Contents
- [🌍 General Context](#-general-context)
- [🧪 Exercise Overview](#-exercise-overview)
- [📄 Description of the VCF File](#-description-of-the-vcf-file)
- [🧬 Part 1: Extract APOL1 Variants](#-part-1-extract-apol1-variants)
- [🧩 Part 2: Build Risk Alleles](#-part-2-build-risk-alleles)
- [📊 Part 3: Frequency Computation](#-part-3-frequency-computation)
- [🧫 Supplementary Exercise: p.N264K](#-supplementary-exercise-pn264k)

## 🌍 General Context

<details markdown="1">
  <summary>🧬 Click to expand</summary>

**APOL1 (Apolipoprotein L1)** is on **chromosome 22 (22q12.3)** and is involved in **innate immunity** and protection against *Trypanosoma* parasites.

Two coding variants — **G1** and **G2** — are strongly associated with **kidney disease risk** among individuals of **African ancestry**.

### 🔹 G1 and G2 Variants
- **G1**: missense mutations `rs73885319 (S342G)` and `rs60910145 (I384M)`
- **G2**: 6 bp deletion `rs71785313` removing **N388** and **Y389**

**High-risk genotypes** (`G1/G1`, `G2/G2`, `G1/G2`) increase risk of FSGS, ESKD, and HIVAN.

### 🌍 Population Frequency and Selection
- High in **West/Central Africa**; lower in **East/Southern Africa**; rare elsewhere.
- Reflects **balancing selection** (protection vs. kidney risk).

### 🧪 p.N264K Protective Variant
```
rs73885316 (chr22:36265628 C > A, p.N264K)
```
A rare **modifier** that may reduce APOL1-mediated toxicity while retaining trypanolysis.

**Key takeaway:** evolutionary trade-off: infection resistance vs. kidney disease susceptibility.

</details>

## 🧪 Exercise Overview

<details markdown="1">
  <summary>🧭 Click to expand</summary>

You will:
1. Manipulate **VCF files**
2. Extract **APOL1 genotypes**
3. Build **G0/G1/G2** genotypes
4. Compute **frequencies** by population

Data: [Dataset link](https://github.com/jeantristanb/kidneygenafrica_course_january_2026/tree/main/day2_apol1/Data)

</details>

## 📄 Description of the VCF File

<details markdown="1">
  <summary>🗂️ Click to expand</summary>

### Structure
- **Header**: `##...`, ends with `#CHROM`
- **Data**: columns `CHROM POS ID REF ALT QUAL FILTER INFO FORMAT Samples...`

### Example
```
#CHROM  POS       ID          REF  ALT  QUAL  FILTER  INFO  FORMAT  Sample1  Sample2
22      36661906  rs73885319  G    A    99    PASS    DP=42 GT      0/1      1/1
22      36662063  rs60910145  T    G    99    PASS    DP=38 GT      0/0      0/1
```

### Tools
- `bcftools`, `vcftools`, `plink`
- `R`, `Python` for small/medium data

</details>

## 🧬 Part 1: Extract APOL1 Variants

<details markdown="1">
  <summary>🔍 Click to expand</summary>

### Objective
Extract genotypes of **G1**, **G2**, **p.N264K** from a VCF and save `APOL1_risk_genotypes.csv`.

### R snippet
```r
genotypes <- c("0|1", "1|1", "0|0")
split_geno <- strsplit(genotypes, "|", fixed = TRUE)
geno1 <- sapply(split_geno, `[`, 1)
```

### Expected Output
| ID | rs73885319_h1 | rs73885319_h2 | rs60910145_h1 | rs60910145_h2 | rs71785313_h1 | rs71785313_h2 |
|---|---|---|---|---|---|---|
| HG00096 | G | A | G | G | C | - |
| HG00097 | A | A | G | A | - | - |
| HG00099 | G | G | G | G | C | C |

</details>

## 🧩 Part 2: Build Risk Alleles

<details markdown="1">
  <summary>🧠 Click to expand</summary>

### Haplotype Definitions
| Haplotype | rs73885319 | rs60910145 | rs71785313 | Description |
|---|---|---|---|---|
| G0 | A | T | AATAATT | Low risk |
| G1 | G | G | AATAATT | Two missense mutations |
| G2 | A | T | A | 6 bp deletion |

### Application
Combine variants to assign **haplotypes** and build **genotypes** (`G0/G1`, `G1/G2`, …).  
Classify **high-risk** if two risk haplotypes (`G1/G1`, `G2/G2`, `G1/G2`).

| ID | riskallele_h1 | riskallele_h2 | haplo_apol1 | high_risk |
|---|---|---|---|---|
| HG00096 | G1 | G0 | G1/G0 | 0 |
| HG00097 | G0 | G2 | G0/G2 | 0 |
| HG00099 | G1 | G1 | G1/G1 | 1 |

</details>

## 📊 Part 3: Frequency Computation

<details markdown="1">
  <summary>📈 Click to expand</summary>

Compute allele/genotype frequencies by **superpopulation**.

| SuperPopulation | G0_freq | G1_freq | G2_freq |
|---|---|---|---|
| EUR | 1.00 | 0.00 | 0.00 |
| AFR | 0.40 | 0.80 | 0.60 |

</details>

## 🧫 Supplementary Exercise: p.N264K

<details markdown="1">
  <summary>🧬 Click to expand</summary>

Tasks:
1. Co-occurrence of **p.N264K** with **G1** vs **G2**
2. Allele frequencies by population
3. Interpretation (selection & risk modulation)

</details>

## 📘 Credits
Prepared by **Jean-Tristan Brandenburg**.
