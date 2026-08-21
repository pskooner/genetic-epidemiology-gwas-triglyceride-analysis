#!/usr/bin/env bash

# Genome-Wide Association Analysis of Triglyceride Levels
# Script 05: SNP-Level Association Analysis
# Author: Parminder Kooner

set -euo pipefail

GENO_PREFIX="data/geno_final"
PHENO_FILE="results/tg.pheno"
COVAR_FILE="results/tg.covar"
OUTPUT_PREFIX="results/tg_gwas"

mkdir -p results

# Covariate-adjusted SNP-level linear regression

plink \
  --file "${GENO_PREFIX}" \
  --pheno "${PHENO_FILE}" \
  --covar "${COVAR_FILE}" \
  --linear \
  --out "${OUTPUT_PREFIX}"

# Extract additive-model results

awk '
NR == 1 || $5 == "ADD"
' "${OUTPUT_PREFIX}.assoc.linear" \
  > results/tg_gwas_additive.txt

# Sort additive-model results by p-value

{
  head -n 1 results/tg_gwas_additive.txt

  tail -n +2 results/tg_gwas_additive.txt \
    | sort -g -k9
} > results/tg_gwas_additive_sorted.txt

echo
echo "Top association results:"
head results/tg_gwas_additive_sorted.txt

echo
echo "Association analysis completed."
