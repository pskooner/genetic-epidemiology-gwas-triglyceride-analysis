# Genome-Wide Association Analysis of Triglyceride Levels
# Script 01: Data Inspection
# Author: Parminder Kooner

# Input files
map_file <- "data/geno_final.map"
ped_file <- "data/geno_final.ped"
pheno_file <- "data/pheno_final.csv"

# Read genotype data

map <- read.table(
  map_file,
  header = FALSE,
  stringsAsFactors = FALSE
)

ped <- read.table(
  ped_file,
  header = FALSE,
  stringsAsFactors = FALSE
)

# Inspect genotype data

cat("\nMAP file dimensions:\n")
print(dim(map))

cat("\nPED file dimensions:\n")
print(dim(ped))

cat("\nFirst six rows of MAP file:\n")
print(head(map))

cat("\nFirst six rows of PED file:\n")
print(head(ped))

cat("\nNumber of SNPs:\n")
print(nrow(map))

cat("\nSNPs by chromosome:\n")
print(table(map$V1))

# Read phenotype data

pheno <- read.csv(
  pheno_file,
  stringsAsFactors = FALSE
)

# Inspect phenotype data

cat("\nPhenotype file dimensions:\n")
print(dim(pheno))

cat("\nPhenotype structure:\n")
str(pheno)

cat("\nPhenotype summary:\n")
print(summary(pheno))
