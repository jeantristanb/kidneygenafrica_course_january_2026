# 🧬 Training Exercise: APOL1 Risk Variants and CKD Progression

---

## 📑 Table of Contents
- [🌍 General Context](#-general-context)
- [🧪 Exercise Overview](#-exercise-overview)
- [📄 Description of the VCF File](#-description-of-the-vcf-file)
- [🧬 Part 1: Extract APOL1 Variants](#-part-1-extract-apol1-variants)
- [🧩 Part 2: Build Risk Alleles](#-part-2-build-risk-alleles)
- [📊 Part 3: Frequency Computation](#-part-3-frequency-computation)
- [🧫 Supplementary Exercise: p.N264K](#-supplementary-exercise-pn264k)

---

## 🌍 General Context

<details>
  <summary>🧬 Click to expand</summary>

The **APOL1 (Apolipoprotein L1)** gene, located on **chromosome 22 (22q12.3)**, encodes a protein involved in **innate immunity** and **protection against *Trypanosoma* parasites** that cause *African sleeping sickness*.

Two common coding variants — **G1** and **G2** — are **strongly associated** with increased susceptibility to **kidney diseases**, particularly among individuals of **African ancestry**.

---

### 🔹 G1 and G2 Variants

- **G1 variant** → two missense mutations:  
  - `rs73885319 (S342G)`  
  - `rs60910145 (I384M)`
- **G2 variant** → a **6–base pair deletion** (`rs71785313`) removing amino acids **N388** and **Y389**.

🧬 **High-risk genotypes** — carrying **two risk alleles** (`G1/G1`, `G2/G2`, or `G1/G2`) — increase the risk of:
- FSGS  
- Hypertension-attributed ESKD  
- HIV-associated nephropathy (HIVAN)

This illustrates an **evolutionary trade-off**: protection against infection at the **cost of kidney disease risk**.

---

### 🌍 Population Frequency and Selection

- **High-risk alleles** occur almost exclusively in individuals of **recent African ancestry**.  
- Combined frequency: **10%–40%** in **West Africa**, rare elsewhere.  
- **G1** more common in *West/Central Africa*, **G2** in *East/Southern Africa*.  

🧩 Reflects **balancing selection** — alleles maintained for trypanosome resistance despite kidney risk.

---

### 🧪 The p.N264K Protective Variant

```text
rs73885316 (chr22:36265628 C > A, p.N264K)
```

- A **rare protective variant**, possibly mitigating **APOL1 cytotoxic effects**.  
- Alters protein charge (Asn→Lys), modifying SRA binding.  
- May **reduce APOL1-induced toxicity** while retaining trypanolytic activity.  

📊 Occurs at **low frequency (≈3%)** in African ancestry populations and sometimes **coexists with G1 or G2**, suggesting a **modifier effect**.

---

✅ **Key takeaway:**  
**APOL1** is a classic case of **evolutionary trade-off** — infection resistance vs. kidney disease susceptibility in African populations.

</details>

---

## 🧪 Exercise Overview

<details>
  <summary>🧭 Click to expand</summary>

Your collaborator, **Prof. Nephro Log**, has sequenced a dataset across populations to estimate **APOL1 variant prevalence**.

You will:

1. Understand and manipulate **VCF files**  
2. Extract **genotypes** for APOL1 risk variants  
3. Compute **genotype classifications (G0, G1, G2)**  
4. Estimate **allele and genotype frequencies** by population

Data:
- VCF + population file → [Dataset link](https://github.com/jeantristanb/kidneygenafrica_course_january_2026/tree/main/day2_apol1/Data)

</details>

---

## 📄 Description of the VCF File

<details>
  <summary>🗂️ Click to expand</summary>

### 🧬 Structure

- **Header section:** metadata lines starting with `##`, ending with `#CHROM`  
- **Data section:** variant rows (`CHROM`, `POS`, `ID`, `REF`, `ALT`, `QUAL`, etc.)

### ⚙️ Example

```text
#CHROM  POS       ID          REF  ALT  QUAL  FILTER  INFO  FORMAT  Sample1  Sample2
22      36661906  rs73885319  G    A    99    PASS    DP=42 GT      0/1      1/1
22      36662063  rs60910145  T    G    99    PASS    DP=38 GT      0/0      0/1
```

### 📦 Tools

- `bcftools`, `vcftools`, `plink` — for manipulation  
- `R` / `Python` — for small datasets or plotting  

</details>

---

## 🧬 Part 1: Extract APOL1 Variants

<details>
  <summary>🔍 Click to expand</summary>

### 🎯 Objective
Extract genotypes of **G1**, **G2**, and **p.N264K** variants from a VCF.

### 🧪 Steps

1. Read and filter the VCF for APOL1 positions  
2. Extract genotype columns (`0|1`, `1|1`, etc.)  
3. Split alleles using `strsplit()`  
4. Generate summary table → `APOL1_risk_genotypes.csv`

Example in **R**:
```r
genotypes <- c("0|1", "1|1", "0|0")
split_geno <- strsplit(genotypes, "|", fixed = TRUE)
geno1 <- sapply(split_geno, `[`, 1)
```

---

### 🧾 Expected Output

| ID | rs73885319_h1 | rs73885319_h2 | rs60910145_h1 | rs60910145_h2 | rs71785313_h1 | rs71785313_h2 |
|----|----------------|----------------|----------------|----------------|----------------|----------------|
| HG00096 | G | A | G | G | C | - |
| HG00097 | A | A | G | A | - | - |
| HG00099 | G | G | G | G | C | C |

</details>

---

## 🧩 Part 2: Build Risk Alleles

<details>
  <summary>🧠 Click to expand</summary>

### 🧬 Haplotype Definitions

| Haplotype | rs73885319 | rs60910145 | rs71785313 | Description |
|------------|-------------|-------------|-------------|--------------|
| G0 | A | T | AATAATT | Low risk |
| G1 | G | G | AATAATT | Two missense mutations |
| G2 | A | T | A | In-frame 6 bp deletion |

### ⚙️ Application

1. Combine the three variants to assign each individual a **haplotype**.  
2. Build genotypes (`G0/G1`, `G1/G2`, etc.)  
3. Classify risk level under **recessive model**.

| ID | riskallele_h1 | riskallele_h2 | haplo_apol1 | high_risk |
|----|----------------|----------------|---------------|-------------|
| HG00096 | G1 | G0 | G1/G0 | 0 |
| HG00097 | G0 | G2 | G0/G2 | 0 |
| HG00099 | G1 | G1 | G1/G1 | 1 |

</details>

---

## 📊 Part 3: Frequency Computation

<details>
  <summary>📈 Click to expand</summary>

### 🧠 Context
APOL1 variants (G1, G2) show clear **geographic stratification**:
- **G1:** West Africa  
- **G2:** East Africa  
- **Rare** in non-African populations

### 🧮 Application

Compute allele and genotype frequencies by **superpopulation**.

| SuperPopulation | G0_freq | G1_freq | G2_freq |
|-----------------|----------|----------|----------|
| EUR | 1.00 | 0.00 | 0.00 |
| AFR | 0.40 | 0.80 | 0.60 |

</details>

---

## 🧫 Supplementary Exercise: p.N264K

<details>
  <summary>🧬 Click to expand</summary>

### 🔍 Context

The **p.N264K** variant is a **protective modifier** in the APOL1 gene:
- Reduces **APOL1-mediated toxicity**
- Often **co-occurs with G2**
- Found almost exclusively in **African ancestry** populations

### 🧩 Tasks

1. Determine whether **p.N264K** co-occurs more with **G1** or **G2**.  
2. Compute allele frequencies by population.  
3. Interpret in the context of **selection** and **disease risk modulation**.

</details>

---

## 📘 References and Credits

Prepared by **Jean-Tristan Brandenburg**  
Part of *CKD progression and APOL1 risk allele* training module.  
Inspired by **AWI-GEN** and **KidneyGenAfrica** data projects.

---
