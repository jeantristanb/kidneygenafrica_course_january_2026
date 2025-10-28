# training Exercise for APOL1
## context 
The APOL1 (Apolipoprotein L1) gene, located on chromosome 22 (22q12.3), encodes a protein involved in innate immunity and protection against certain Trypanosoma parasites that cause African sleeping sickness. However, two common coding variants — known as the G1 and G2 risk alleles — have been strongly associated with increased susceptibility to kidney diseases, particularly in individuals of African ancestry. The G1 variant consists of two missense mutations (rs73885319 [S342G] and rs60910145 [I384M]), while the G2 variant involves a 6–base pair deletion (rs71785313) that removes two amino acids (N388 and Y389). Individuals carrying two risk alleles (G1/G1, G2/G2, or G1/G2) are at significantly higher risk for developing conditions such as focal segmental glomerulosclerosis (FSGS), hypertension-attributed end-stage kidney disease (ESKD), and HIV-associated nephropathy (HIVAN). These variants illustrate a striking example of evolutionary trade-off, where protection against infection has come at the cost of increased kidney disease risk.

The frequency of APOL1 high-risk alleles varies markedly across populations, reflecting their evolutionary history and selective pressures. The G1 and G2 variants are found almost exclusively in individuals of recent African ancestry, with combined risk allele frequencies ranging from 10% to over 40% in West African populations, where exposure to Trypanosoma brucei was historically common. In contrast, these variants are rare or absent in non-African populations, including Europeans, Asians, and Indigenous American groups. Within Africa, the distribution is heterogeneous — higher in West and Central Africa (e.g., Yoruba, Igbo) and lower in East and Southern Africa, mirroring the geographic spread of T. brucei gambiense and T. b. rhodesiense. This population variability highlights the strong balancing selection that maintained APOL1 risk alleles in regions where they conferred protection against trypanosome infection, despite their detrimental effects on kidney function.

A third APOL1 variant of emerging interest is p.N264K (rs73885316), located in the SRA-interacting domain of the APOL1 protein. Unlike the G1 and G2 high-risk alleles, which increase kidney disease susceptibility, p.N264K appears to be a protective variant that may mitigate the cytotoxic effects of APOL1 risk genotypes. The asparagine-to-lysine substitution at position 264 alters the protein’s charge and conformation in a region important for interaction with the Trypanosoma brucei serum resistance–associated (SRA) protein. Functional studies suggest that this mutation can reduce APOL1-induced cell toxicity by modulating ion channel activity or intracellular localization, without fully compromising trypanolytic function. Population studies show that p.N264K occurs at low frequencies in individuals of African ancestry, and it often coexists on the same haplotype background as G1 or G2. Its presence has been associated with attenuated kidney disease risk among carriers of APOL1 high-risk genotypes, making it a promising target for understanding genetic modifiers and developing therapeutic strategies aimed at reducing APOL1-mediated kidney injury.

## Exercise : general description

Your collaborator, Prof. Nephro Log, has sequenced a dataset including individuals from different continents and ethnic backgrounds using whole-genome sequencing. The goal is to estimate the prevalence of APOL1 high-risk variants and the p.N264K variant. However, your collaborator does not have the necessary skills to analyze the dataset.

You have received the following files:

* A VCF file containing the genotyped data
* A population information file describing the population or ethnic background of each individual

The aim of this work is to:

- **Understand the VCF format** and explore the main tools available to manipulate and process Variant Call Format (VCF) files.

- **Extract individual SNP genotypes** from the VCF corresponding to the **APOL1 risk variants**:
  - `rs73885319`
  - `rs60910145`
  - `rs71785313`

- **Compute APOL1 genotypes (G0, G1, G2)** for each individual and classify them according to the **recessive risk model**, where:
  - Individuals carrying **two risk alleles** (`G1/G1`, `G2/G2`, or `G1/G2`) are considered **high-risk**.
  - Individuals with other genotypes (`G0/G0`, `G0/G1`, or `G0/G2`) are considered **low-risk**.

- **Estimate allele and genotype frequencies by population** to evaluate the distribution and variability of **APOL1 risk alleles** across groups.

## 📄 Description of the VCF File

The **Variant Call Format (VCF)** is a standard text file format used in bioinformatics to represent genetic variation data such as **single nucleotide polymorphisms (SNPs)**, **insertions**, and **deletions** identified in one or more samples.

A VCF file is divided into two main sections:

1. **Header section**  
   Begins with lines starting with `##` that describe metadata (e.g., reference genome, annotation sources, file format version).  
   The final header line starts with `#CHROM` and defines the column names, including sample identifiers.

2. **Data section**  
   Each subsequent line represents a genomic variant with the following standard columns:
   - `CHROM`: Chromosome name  
   - `POS`: Genomic position  
   - `ID`: Variant identifier (e.g., rsID)  
   - `REF`: Reference allele  
   - `ALT`: Alternate allele(s)  
   - `QUAL`: Quality score for the variant call  
   - `FILTER`: Filter status of the variant  
   - `INFO`: Additional information and annotations  
   - `FORMAT`: Describes the structure of genotype fields  
   - **Sample columns**: Genotype data and related information for each individual (e.g., `0/0`, `0/1`, `1/1`)

### 🧬 Genotype Representation and Phasing

Each genotype is represented using allele codes:
- `0` = reference allele  
- `1` = alternate allele  

For example:
- `0/0` → homozygous reference  
- `0/1` → heterozygous  
- `1/1` → homozygous alternate  

The **separator symbol** between alleles conveys information about **phasing**:
- `0/1` → **unphased** genotype (the origin of each allele—maternal or paternal—is unknown).  
- `0|1` → **phased** genotype, indicating the alleles are assigned to specific haplotypes (e.g., `0` on the maternal chromosome and `1` on the paternal).  

Phasing is particularly important in **haplotype-based analyses**, such as imputation, recombination rate estimation, or studies of compound heterozygosity.  
Phased VCFs are usually the output of tools such as **SHAPEIT**, **BEAGLE**, or **Eagle**.

### ⚙️ File Handling

VCF files are often compressed (`.vcf.gz`) and indexed (`.tbi`) for efficient storage and querying.  
They can be manipulated using tools such as:
- **bcftools** — for querying, filtering, merging, and annotation  
- **vcftools** — for quality control and summary statistics  
- **plink** — for genotype conversion, association testing, and frequency computation

### 🧩 Example of a VCF File

Below is a simplified example of a VCF file showing both **unphased** (`/`) and **phased** (`|`) genotypes.

```text
##fileformat=VCFv4.2
##reference=GRCh38
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
#CHROM  POS       ID           REF  ALT  QUAL  FILTER  INFO     FORMAT  Sample1  Sample2  Sample3
22      36661906  rs73885319   G    A    99    PASS    DP=42    GT      0/1      1/1      0|1
22      36662063  rs60910145   T    G    99    PASS    DP=38    GT      0/0      0/1      1|1
22      36662158  rs71785313   TTAT  T    99    PASS    DP=45    GT      0|0      1|0      1|1
```

## Part.1 Extract APOL1 Variants 

### Variants

[**APOL1**](https://www.ensembl.org/Homo_sapiens/Gene/Summary?g=ENSG00000100342;r=22:36253071-36267530)  
is a gene located on **chromosome 22: 36,253,071–36,267,530 (GRCh38/hg38)**.  
It encodes Apolipoprotein L1, involved in innate immunity and parasitic resistance.  
Certain variants in this gene—known as **G1** and **G2**—are associated with increased kidney disease risk in individuals of recent African ancestry.

| rsID         | Chr | Position (hg38) | REF → ALT        | Amino Acid Change            | Functional Role         | Description |
|--------------|-----|----------------|------------------|------------------------------|--------------------------|-------------|
| **rs73885319** | 22  | 36,265,860     | A → G            | p.S342G (Ser → Gly)          | **G1** variant           | One of two missense mutations defining the G1 haplotype. :contentReference[oaicite:0]{index=0} |
| **rs60910145** | 22  | 36,265,988     | T → G            | p.I384M (Ile → Met)          | **G1** variant           | Occurs in strong LD with rs73885319; together define G1. :contentReference[oaicite:1]{index=1} |
| **rs71785313** | 22  | 36,265,995     | TTATAA → – (6 bp del) | p.N388_Y389del            | **G2** variant           | In-frame 6 bp deletion removing two amino acids; defines G2. :contentReference[oaicite:2]{index=2} |
| **rs73885316** | 22  | 36,265,628     | A → G            | p.N264K (Asn → Lys)          | **Modifier / Protective**| Rare variant; may attenuate APOL1 risk when co-inherited. :contentReference[oaicite:3]{index=3} |
| —             | —   | —              | —                | —                            | **G0 (Reference)**       | Reference haplotype: neither G1 nor G2 present; low-risk. |

#### 🧠 Notes
- **G1** is defined by the *combined presence* of rs73885319 (A→G) and rs60910145 (T→G) on the same haplotype. :contentReference[oaicite:4]{index=4}  
- **G2** is an *in-frame deletion* (rs71785313: TTATAA → deletion) removing residues N388 and Y389. :contentReference[oaicite:5]{index=5}  
- Individuals carrying **two risk alleles** (G1/G1, G2/G2, or G1/G2) are classified as **high-risk** under a recessive model.  
- The **p.N264K (rs73885316)** variant is a *potential protective modifier*, observed in low frequency in African ancestry populations.  
- Coordinates correspond to the **GRCh38 (hg38)** reference genome.

---

### 🧬 Application : Extract APOL1 Risk Alleles (Including p.N264K) from a VCF File

#### 🧠 Objective

From a collaborator’s VCF file, extract the **genomic positions** and **individual genotypes** for the **APOL1 risk variants**, including **p.N264K (rs73885319)**.

---

#### 📂 Files

The file `Data/chr22.apol1.vcf` contains approximately **3,000 samples** with variants located around the **APOL1 gene**.  
All genotypes in this file are **phased**, meaning that alleles are represented as `0|1`, `1|0`, or `1|1`.

---

#### 🧪 Steps

Using **R** (or any equivalent tool), extract from the provided VCF file:

1. The **positions** and **IDs** of the APOL1 variants of interest.  
2. The **individual phased genotypes** (e.g., `0|1`, `1|1`, or `0|0`).  
3. Replace genotype encodings:  
   - `0` → Reference allele (**REF**)  
   - `1` → Alternate allele (**ALT**)  
4. Create a summary table containing **REF/ALT alleles per sample** for each variant.  
5. Save the final table as `APOL1_risk_genotypes.csv`.

💬 *Note:*  
R is not mandatory. You can use other tools (e.g., `bcftools`, `awk`, or `plink`) to achieve the same result.

---

#### 🧾 Expected Output

```text
ID        rs73885319_g1   rs73885319_g2   rs60910145_g1   rs60910145_g2   rs71785313_g1   rs71785313_g2   rs73885316_g1   rs73885316_g2
HG00096   G               A               G               G               C               -               G               G
HG00097   A               A               G               A               -               -               G               A
HG00099   G               G               G               G               C               C               G               G

```

## Part.2 Excercice : Built risk allele 

### 🧬 APOL1 Haplotype Definitions

This table summarizes the **allelic composition** of the main APOL1 haplotypes  
(**G0**, **G1**, and **G2**) across the key variants defining kidney disease risk.

| Haplotype | rs73885319 (p.S342G) | rs60910145 (p.I384M) | rs71785313 (p.N388_Y389del) | Description |
|------------|----------------------|----------------------|-----------------------------|--------------|
| **G0 (Reference)** | A (REF) | T (REF) | TTATAA (REF) | Reference haplotype — no risk variants; low-risk. |
| **G1** | G (ALT) | G (ALT) | TTATAA (REF) | Contains two missense mutations (S342G and I384M) on the same haplotype; high-risk. |
| **G2** | A (REF) | T (REF) | — (6 bp deletion) | In-frame deletion removing N388 and Y389; high-risk. |

### 🧠 Notes

- **G1** and **G2** are **mutually exclusive** haplotypes (do not occur together on the same chromosome).  
- **G1** is defined by rs73885319 (A→G) and rs60910145 (T→G).  
- **G2** is defined by the 6 bp deletion at rs71785313 (TTATAA→–).  
- Individuals carrying **two risk haplotypes** (G1/G1, G2/G2, or G1/G2) are considered **high-risk** under a recessive model.  
- Coordinates correspond to the **GRCh38 (hg38)** reference genome.

### 🧬 Application : build G0 / G1 / G2

Using the table describing the **G0**, **G1**, and **G2** haplotypes and the corresponding **rsIDs**,  
and based on the results from the previous exercise,  
build for each individual their **APOL1 genotype** (combination of two haplotypes, e.g., G0/G1, G1/G1, G2/G0, etc.).

Then, classify individuals according to the **recessive risk model**,  
where those carrying **two risk haplotypes** (`G1/G1`, `G2/G2`, or `G1/G2`) are considered **high-risk**,  
and all others (`G0/G0`, `G0/G1`, `G0/G2`) are considered **low-risk**.

### 🧾 Example of Expected Output

After computing the APOL1 genotypes for each individual using the variants  
`rs73885319`, `rs60910145`, and `rs71785313`,  
the resulting summary table could look like this:

| ID        | APOL1_G1 | APOL1_G2 | Genotype | HighRisk |
|------------|-----------|-----------|-----------|-----------|
| HG00096    | 1         | 1         | G1/G2     | 1 |
| HG00097    | 1         | 0         | G1/G0     | 0 |
| HG00098    | 0         | 0         | G0/G0     | 0 |

### 🧠 Notes

- **APOL1_G1** = 1 if the individual carries a G1 haplotype (based on rs73885319 + rs60910145), otherwise 0.  
- **APOL1_G2** = 1 if the individual carries a G2 haplotype (rs71785313 deletion), otherwise 0.  
- **Genotype** represents the combination of two haplotypes (e.g., `G0/G1`, `G1/G2`, `G2/G2`, etc.).  
- **HighRisk** = 1 (high-risk) if the individual carries **two risk haplotypes** (`G1/G1`, `G2/G2`, or `G1/G2`); otherwise 0 (low-risk).  
- This classification follows the **recessive risk model** commonly used in APOL1 studies.

---

## 📊 Frequency Computation

### 🧠 Context


Genetic variant frequencies evolve over time under the influence of **demographic processes** (e.g., admixture, bottlenecks, migration) and **natural selection**.  
In the case of the **APOL1 gene**, the high-risk variants **G1** and **G2** arose in **West Africa** and were maintained by **positive selection** due to their roles in protection against *Trypanosoma brucei* parasites, which cause African sleeping sickness.

- **G1**: Confers **resistance to *Trypanosoma brucei gambiense*** infection, the agent of chronic sleeping sickness in West and Central Africa, although it may not be protective in other contexts.  
- **G2**: Is associated with **increased susceptibility to severe *T.b. gambiense*** disease but also with **reduced susceptibility to *T.b. rhodesiense***, which predominates in East Africa.  

As human populations migrated, mixed, and adapted to different selective pressures, the **distribution of G1 and G2 alleles** diverged geographically:
- **G1** is most frequent in **West Africa** (where *T.b. gambiense* is endemic).  
- **G2** occurs more commonly in **East Africa**, reflecting exposure to *T.b. rhodesiense*.  
- Outside Africa, both variants are **rare or absent**, consistent with the absence of trypanosome-driven selection.

Understanding how **APOL1 allele frequencies** vary between populations provides insights into:
- The **evolutionary history** of human adaptation to pathogens,  
- **Population structure** and migration events, and  
- The **distribution of kidney disease risk** across ancestries.

---

### 🧬 Applications 

Using your dataset containing **individual IDs**, **ethnicity or population origin**, and **APOL1 genotype data** (`G0`, `G1`, `G2`):

1. **Group individuals by population or ancestry** (e.g., African America, West African, East African, European, etc.).
2. **Compute allele frequencies** for each variant:
   - Frequency of **G1 alleles** (from rs73885319 and rs60910145),
   - Frequency of **G2 alleles** (from rs71785313),
   - Optionally, compute **genotype frequencies** (e.g., G0/G0, G1/G1, G2/G2, G1/G2).
3. **Compare frequency differences** between populations to assess **allelic diversity** and **population differentiation**.



#### 🧾 Example of Output

| Population | G1_freq | G2_freq | G0/G0 | G0/G1 | G0/G2 | G1/G1 | G1/G2 | G2/G2 | HighRisk_freq |
|-------------|----------|----------|--------|--------|--------|--------|--------|----------------|
| WestAfrica  | 1.00     | 0.00     | 0.25   | 0.25   | 0.00   | 0.25   | 0.00   | 0.25 |
| EastAfrica  | 0.50     | 1.00     | 0.25   | 0.00   | 0.25   | 0.00   | 0.25   | 0.50 |
| Europe      | 0.00     | 0.50     | 0.50   | 0.00   | 0.25   | 0.00   | 0.00   | 0.00 |

### 🧬 Supplementary Exercise: p.N264K

The **p.N264K** variant (**rs73885316**) is a **rare missense mutation** in the *APOL1* gene (Asparagine → Lysine at position 264).  
Unlike the well-known **G1** and **G2** risk alleles, **p.N264K** is not itself associated with kidney disease risk — rather, it appears to act as a **protective modifier**.

---

#### 🔍 Context

- The **p.N264K** variant occurs in the **SRA-interacting domain** of APOL1, which is crucial for the protein’s trypanolytic activity.  
- Functional studies suggest that **p.N264K** can **reduce APOL1-mediated cytotoxicity** without fully compromising trypanosome resistance.  
- This variant tends to **co-occur on the same haplotype as G2**, and less commonly with G1, suggesting a possible **modifier effect** on G2-associated risk.  

**Key relationships:**
- 🧩 **p.N264K + G2** → Often found together (on the same haplotype).  
- 🔬 **p.N264K + G1** → Rare association.  
- 🧫 **p.N264K + G0** → Sometimes observed, usually in individuals of African ancestry without high-risk alleles.

---

#### 🌍 Population Distribution

- **p.N264K** is observed **almost exclusively in African ancestry populations**.  
- The **highest frequencies** have been reported in **West and Central African populations**, though still typically **below 5%**.  
- It is **rare or absent** in **non-African** populations (e.g., European, Asian, or Native American).  
- Because it frequently occurs with **G2**, it shows slightly higher prevalence in regions where **G2** is common — particularly in **East Africa**.

---

#### 🧠 Exercise

Using your dataset that includes **p.N264K genotypes** (rs73885316) and **APOL1 G1/G2 status**:

1. **Determine** with which high-risk allele (G1 or G2) the p.N264K variant most frequently co-occurs.  
2. **Compute allele frequencies** of p.N264K by population or ancestry group.  
3. **Interpret** the results in the context of:
   - Evolutionary history of APOL1 variants,  
   - Geographic exposure to *Trypanosoma brucei*, and  
   - The potential **protective role** of p.N264K in mitigating kidney disease risk among G2 carriers.

