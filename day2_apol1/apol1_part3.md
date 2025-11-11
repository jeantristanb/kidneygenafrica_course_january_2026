# 📊 Part. 3 Frequency Computation

## 🧠 Context


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

## 🧬 Applications

Using your dataset containing **individual IDs**, **ethnicity or population origin**, and **APOL1 genotype data** (`G0`, `G1`, `G2`):

1. **Group individuals by population or ancestry**  
   (e.g., African American, West African, East African, European, etc.).

2. **Compute allele frequencies** for each variant:
   - Frequency of **G1 alleles** (from `rs73885319` and `rs60910145`),  
   - Frequency of **G2 alleles** (from `rs71785313`),  
   - Optionally, compute **genotype frequencies** (e.g., `G0/G0`, `G0/G1`, `G1/G1`, `G0/G2`, `G1/G2`, `G2/G2`),  
   - Compare frequencies by **superpopulation** (e.g., AFR, EUR, EAS, AMR, SAS) and, when relevant, by **subpopulation**.

3. **Compare frequency differences** between populations to evaluate **allelic diversity**, **population differentiation**, and potential **selection signatures**.

---

### 🧾 Example of Output

| SuperPopulation | G0_freq | G1_freq | G2_freq |
|-----------------|----------|----------|----------|
| EUR             | 1.00     | 0.00     | 0.25     |
| AMR             | 0.50     | 1.00     | 0.25     |
| AFR             | 0.40     | 0.80     | 0.60     |

---

## 🧠 Notes

- **G1_freq** and **G2_freq** represent the proportion of alleles observed in each superpopulation.  
- **G0_freq** can be derived as `1 - (G1_freq + G2_freq)` when appropriate.  
- You may extend this to compute **high-risk genotype frequencies** (`G1/G1`, `G1/G2`, `G2/G2`) within or across populations.  
- Results should reflect known **geographic and selective patterns**:  
  - High **G1** frequency in **West Africa**,  
  - High **G2** frequency in **East Africa**,  
  - Near absence of both in **non-African** groups.

---
