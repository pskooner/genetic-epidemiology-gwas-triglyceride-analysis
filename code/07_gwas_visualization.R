# Genome-Wide Association Analysis of Triglyceride Levels
# Script 07: GWAS Visualization and Genomic Inflation
# Author: Parminder Kooner

association_file <- "results/tg_gwas.assoc.linear"
regional_file <- "results/tg_region_100kb.txt"

figures_dir <- "figures"
results_dir <- "results"

dir.create(figures_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Read association results

results <- read.table(
  association_file,
  header = TRUE,
  stringsAsFactors = FALSE
)

results <- subset(
  results,
  TEST == "ADD" & !is.na(P)
)

# Manhattan-style chromosome 19 association plot

png(
  "figures/manhattan_plot.png",
  width = 1200,
  height = 800,
  res = 150
)

plot(
  results$BP,
  -log10(results$P),
  pch = 20,
  xlab = "Base-Pair Position on Chromosome 19",
  ylab = expression(-log[10](P)),
  main = "Association of Chromosome 19 Variants with Triglyceride Levels"
)

abline(
  h = -log10(5e-8),
  lty = 2
)

dev.off()

# Q-Q plot

observed <- -log10(
  sort(results$P)
)

expected <- -log10(
  ppoints(length(observed))
)

png(
  "figures/qq_plot.png",
  width = 1200,
  height = 800,
  res = 150
)

plot(
  expected,
  observed,
  pch = 20,
  xlab = expression(Expected~~-log[10](P)),
  ylab = expression(Observed~~-log[10](P)),
  main = "Q-Q Plot of Association P-values"
)

abline(
  0,
  1,
  lty = 2
)

dev.off()

# Genomic control inflation factor

chi_square <- qchisq(
  1 - results$P,
  df = 1
)

lambda_gc <- median(
  chi_square,
  na.rm = TRUE
) / qchisq(
  0.5,
  df = 1
)

cat(
  "\nGenomic control inflation factor (lambda GC):",
  round(lambda_gc, 5),
  "\n"
)

write.table(
  data.frame(
    lambda_GC = lambda_gc
  ),
  "results/genomic_inflation_factor.txt",
  quote = FALSE,
  row.names = FALSE
)

# Basic regional association plot

regional <- read.table(
  regional_file,
  header = TRUE,
  stringsAsFactors = FALSE
)

lead_snp <- regional[
  which.min(regional$P),
]

png(
  "figures/regional_association_plot.png",
  width = 1200,
  height = 800,
  res = 150
)

plot(
  regional$BP,
  -log10(regional$P),
  pch = 20,
  xlab = "Base-Pair Position",
  ylab = expression(-log[10](P)),
  main = paste(
    "Regional Association Plot around",
    lead_snp$SNP
  )
)

points(
  lead_snp$BP,
  -log10(lead_snp$P),
  pch = 8,
  cex = 1.5
)

dev.off()

cat("\nGWAS figures generated successfully.\n")
