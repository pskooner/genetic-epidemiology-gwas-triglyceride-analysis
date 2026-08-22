# Genome-Wide Association Analysis of Triglyceride Levels

## Overview

This project presents a genetic association analysis of triglyceride levels conducted as part of graduate coursework in genetic epidemiology at UTHealth Houston School of Public Health.

The analysis used **PLINK, R, and Unix/Linux** to implement a workflow encompassing genotype quality control, phenotype assessment and transformation, covariate preparation, genetic association testing, and genomic visualization.

The dataset included **1,200 participants and 830 single nucleotide polymorphisms (SNPs) on chromosome 19**. Triglyceride levels were evaluated as the primary quantitative phenotype.

---

## Objectives

The primary objectives of the analysis were to:

* Assess individual- and variant-level genotype missingness
* Evaluate minor allele frequencies (MAF)
* Assess Hardy-Weinberg equilibrium (HWE)
* Summarize demographic and phenotype characteristics
* Examine the distributions of triglycerides and body mass index (BMI)
* Apply appropriate transformations prior to association testing
* Conduct SNP-level association testing using linear regression
* Adjust association models for relevant covariates
* Identify and characterize the strongest association signal
* Generate a regional association plot around the lead SNP
* Visualize genome-wide association results using Manhattan and Q-Q plots
* Evaluate genomic inflation using the genomic control inflation factor (λ)

---

## Dataset

The analysis included:

* **1,200 participants**
* **830 SNPs**
* **Chromosome:** 19
* **Primary phenotype:** Triglyceride levels (TG)
* **Covariates:** Age, sex, and body mass index (BMI)

The original genotype and phenotype datasets were provided for graduate coursework and are therefore **not redistributed in this repository**.

---

## Analysis Workflow
The complete analysis code is available in the [code directory](code/).

### 1. Data Inspection

Genotype, marker, and phenotype files were inspected using R and Unix/Linux to verify dataset structure, participant counts, SNP counts, and variable coding.

### 2. Genotype Quality Control

Genotype quality control was performed using **PLINK** and included assessment of:

* Individual-level genotype missingness
* Variant-level genotype missingness
* Minor allele frequency
* Hardy-Weinberg equilibrium

The dataset contained 830 SNPs on chromosome 19. Six SNPs had genotype missingness greater than 10%, while one SNP failed the predefined Hardy-Weinberg equilibrium threshold of *P* ≤ 0.001.

### 3. Phenotype Assessment

The distributions of triglyceride levels and BMI were evaluated using:

* Histograms
* Density plots
* Q-Q plots
* Boxplots
* Shapiro-Wilk tests

Triglyceride levels exhibited substantial positive skew, while BMI showed a milder right-skewed distribution.

Natural logarithm transformations were therefore applied to both variables prior to downstream association analysis.

### 4. Association Analysis

The primary association analysis used:

**Phenotype:**
`log(TG)`

**Covariates:**

* Age
* Sex
* `log(BMI)`

SNP-level linear regression was performed in PLINK using an additive genetic model.

### 5. Lead Association Signal

The strongest association identified in the analysis was:

| Characteristic         | Result        |
| ---------------------- | ------------- |
| Lead SNP               | `rs201957995` |
| Chromosome             | 19            |
| Base-pair position     | 1,974,059 bp  |
| Minor allele frequency | 0.085         |
| Association P-value    | 2.59 × 10⁻⁸⁴  |

The lead SNP demonstrated a highly significant association with log-transformed triglyceride levels after adjustment for age, sex, and log-transformed BMI.

### 6. Regional Association Analysis

A **±100 kb regional association analysis** was conducted around the lead SNP.

The region contained **55 SNPs** and included several annotated genes, including:

* `YJEFN3`
* `CILP2`
* `PBX4`
* `LPAR2`
* `GMIP`
* `ATP13A1`
* `ZNF101`
* `ZNF14`

A regional association plot was generated using **LocusZoom** to visualize the association signal and surrounding genomic region.

### 7. Manhattan and Q-Q Plots

A Manhattan plot was generated to visualize SNP-level association results across chromosome 19. A strong association signal was observed near the lead SNP, while most variants remained below the conventional genome-wide significance threshold.

A Q-Q plot was used to compare observed and expected association statistics.

The genomic control inflation factor was:

**λ = 1.193**

This indicated mild inflation of the association statistics and highlighted the potential influence of factors such as population structure, relatedness, genotyping variation, or residual confounding.

---

## Tools & Technologies

* **PLINK** — genotype quality control and association testing
* **R** — data management, statistical analysis, and visualization
* **Unix/Linux** — command-line data processing and workflow management
* **LocusZoom** — regional association visualization

---

## Repository Structure

```text
triglyceride-gwas-analysis/
│
├── data/                              # Local
│   ├── geno_final.ped
│   ├── geno_final.map
│   └── pheno_final.csv
│
├── code/
│   ├── 01_data_inspection.R
│   ├── 02_genotype_qc.sh
│   ├── 03_phenotype_analysis.R
│   ├── 04_prepare_plink_files.R
│   ├── 05_association_analysis.sh
│   ├── 06_regional_analysis.R
│   └── 07_gwas_visualization.R
│
├── figures/
│   ├── triglyceride_distribution.png
│   ├── bmi_distribution.png
│   ├── log_triglyceride_distribution.png
│   ├── log_bmi_distribution.png
│   ├── manhattan_plot.png
│   ├── qq_plot.png
│   └── regional_association_plot.png
│
├── results/
│   ├── phenotype_summary_statistics.csv
│   ├── tg_gwas_additive_sorted.txt
│   ├── tg_region_100kb.txt
│   └── genomic_inflation_factor.txt
│
├── .gitignore
└── README.md
```

---

## Skills Demonstrated

This project demonstrates experience with:

* Genetic epidemiology
* Statistical genetics
* Genome-wide association analysis
* Genotype quality control
* PLINK
* R programming
* Unix/Linux command-line computing
* Data transformation
* Linear regression
* Covariate-adjusted genetic association testing
* Genomic data visualization
* Manhattan and Q-Q plots
* Regional association analysis
* Genomic inflation assessment
* Reproducible quantitative research

---

## Author

**Parminder Kooner**
M.S. Biostatistics and Data Science
Graduate Certificate in Genomics and Bioinformatics
UTHealth Houston School of Public Health

[LinkedIn](https://www.linkedin.com/in/parmkooner) | [GitHub](https://github.com/pskooner)
