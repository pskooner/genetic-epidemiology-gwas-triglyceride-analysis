#!/usr/bin/env bash

# Genome-Wide Association Analysis of Triglyceride Levels
# Script 02: Genotype Quality Control
# Author: Parminder Kooner

set -euo pipefail

DATA_PREFIX="data/geno_final"
RESULTS_DIR="results"

# Create results directory if it does not exist
mkdir -p "${RESULTS_DIR}"

# Individual- and variant-level genotype missingness

plink \
  --file "${DATA_PREFIX}" \
  --missing \
  --out "${RESULTS_DIR}/genotype_missingness"

# Participants with highest genotype missingness
echo
echo "Participants with highest genotype missingness:"
sort -nr -k6 "${RESULTS_DIR}/genotype_missingness.imiss" | head

# Variants with highest genotype missingness
echo
echo "Variants with highest genotype missingness:"
sort -nr -k5 "${RESULTS_DIR}/genotype_missingness.lmiss" | head

# Minor allele frequencies

plink \
  --file "${DATA_PREFIX}" \
  --freq \
  --out "${RESULTS_DIR}/allele_frequency"

# Hardy-Weinberg equilibrium

plink \
  --file "${DATA_PREFIX}" \
  --hardy \
  --out "${RESULTS_DIR}/hardy_weinberg"

echo
echo "Genotype QC completed."
