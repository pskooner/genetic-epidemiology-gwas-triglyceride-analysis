# Genome-Wide Association Analysis of Triglyceride Levels
# Script 06: Regional Association Analysis
# Author: Parminder Kooner

association_file <- "results/tg_gwas.assoc.linear"
results_dir <- "results"

dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Read association results

results <- read.table(
  association_file,
  header = TRUE,
  stringsAsFactors = FALSE
)

# Retain additive-model results with valid p-values
results <- subset(
  results,
  TEST == "ADD" & !is.na(P)
)

# Identify lead SNP automatically

lead_index <- which.min(results$P)
lead_snp <- results[lead_index, ]

cat("\nLead SNP:", lead_snp$SNP, "\n")
cat("Chromosome:", lead_snp$CHR, "\n")
cat("Base-pair position:", lead_snp$BP, "\n")
cat("P-value:", lead_snp$P, "\n")

# Define +/- 100 kb region

window_size <- 100000

lower_bp <- lead_snp$BP - window_size
upper_bp <- lead_snp$BP + window_size

# Extract regional variants

regional_results <- subset(
  results,
  CHR == lead_snp$CHR &
    BP >= lower_bp &
    BP <= upper_bp
)

regional_results <- regional_results[
  order(regional_results$BP),
]

# Save regional results

write.table(
  regional_results,
  "results/tg_region_100kb.txt",
  quote = FALSE,
  row.names = FALSE,
  sep = "\t"
)

cat(
  "\nNumber of SNPs within +/- 100 kb:",
  nrow(regional_results),
  "\n"
)
