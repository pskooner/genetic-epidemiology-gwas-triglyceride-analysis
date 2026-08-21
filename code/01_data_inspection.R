# ============================================================
# Genome-Wide Association Analysis of Triglyceride Levels
# Script 01: Data Inspection
# Author: Parminder Kooner
# ============================================================

# ------------------------------------------------------------
# Project directory
# ------------------------------------------------------------

project_dir <- "C:/Users/HP/OneDrive/Documents/UT Health Houston - MS Biostatistics/Summer 2026/PH 2780 - Genetic Epidemiology/Final Project"

# Set working directory
setwd(project_dir)

# ------------------------------------------------------------
# Read genotype data
# ------------------------------------------------------------

map <- read.table(
  "data/geno_final.map",
  header = FALSE
)

ped <- read.table(
  "data/geno_final.ped",
  header = FALSE
)

# Examine dimensions
dim(map)
dim(ped)

# Preview data
head(map)
head(ped)

# Number of SNPs
nrow(map)

# Distribution of SNPs by chromosome
table(map$V1)

# ------------------------------------------------------------
# Read phenotype data
# ------------------------------------------------------------

pheno <- read.csv(
  "data/pheno_final.csv"
)

# Inspect phenotype dataset
head(pheno)
str(pheno)
summary(pheno)
