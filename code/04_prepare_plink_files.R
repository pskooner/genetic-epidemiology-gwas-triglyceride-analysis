# Genome-Wide Association Analysis of Triglyceride Levels
# Script 04: Phenotype Transformation and PLINK File Preparation
# Author: Parminder Kooner

pheno_file <- "data/pheno_final.csv"
figures_dir <- "figures"
results_dir <- "results"

dir.create(figures_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Read phenotype data

pheno <- read.csv(
  pheno_file,
  stringsAsFactors = FALSE
)

# Natural-log transformations

pheno$logTG <- log(pheno$TG)
pheno$logBMI <- log(pheno$BMI01)

# Plot log-transformed triglycerides

png(
  "figures/log_triglyceride_distribution.png",
  width = 1200,
  height = 800,
  res = 150
)

par(mfrow = c(2, 2))

hist(
  pheno$logTG,
  main = "Histogram of Log-Transformed Triglycerides",
  xlab = "log(TG)"
)

plot(
  density(pheno$logTG, na.rm = TRUE),
  main = "Density Plot of log(TG)",
  xlab = "log(TG)"
)

qqnorm(
  pheno$logTG,
  main = "Q-Q Plot of log(TG)"
)
qqline(pheno$logTG)

boxplot(
  pheno$logTG,
  main = "Boxplot of log(TG)",
  ylab = "log(TG)"
)

dev.off()

# Plot log-transformed BMI

png(
  "figures/log_bmi_distribution.png",
  width = 1200,
  height = 800,
  res = 150
)

par(mfrow = c(2, 2))

hist(
  pheno$logBMI,
  main = "Histogram of Log-Transformed BMI",
  xlab = "log(BMI)"
)

plot(
  density(pheno$logBMI, na.rm = TRUE),
  main = "Density Plot of log(BMI)",
  xlab = "log(BMI)"
)

qqnorm(
  pheno$logBMI,
  main = "Q-Q Plot of log(BMI)"
)
qqline(pheno$logBMI)

boxplot(
  pheno$logBMI,
  main = "Boxplot of log(BMI)",
  ylab = "log(BMI)"
)

dev.off()

# Normality tests after transformation

cat("\nShapiro-Wilk test for log(TG):\n")
print(
  shapiro.test(
    na.omit(pheno$logTG)
  )
)

cat("\nShapiro-Wilk test for log(BMI):\n")
print(
  shapiro.test(
    na.omit(pheno$logBMI)
  )
)

# Complete-case dataset for association analysis

analysis_data <- pheno[
  complete.cases(
    pheno[, c(
      "ID",
      "TG",
      "BMI01",
      "V1AGE01",
      "SEX"
    )]
  ),
]

# PLINK phenotype file

tg_pheno <- data.frame(
  FID = analysis_data$ID,
  IID = analysis_data$ID,
  logTG = analysis_data$logTG
)

write.table(
  tg_pheno,
  file = "results/tg.pheno",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

# PLINK covariate file

tg_covar <- data.frame(
  FID = analysis_data$ID,
  IID = analysis_data$ID,
  AGE = analysis_data$V1AGE01,
  SEX = analysis_data$SEX,
  logBMI = analysis_data$logBMI
)

write.table(
  tg_covar,
  file = "results/tg.covar",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

cat("\nPLINK phenotype and covariate files created.\n")
