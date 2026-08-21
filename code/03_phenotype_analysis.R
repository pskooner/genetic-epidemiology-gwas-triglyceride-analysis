# Genome-Wide Association Analysis of Triglyceride Levels
# Script 03: Phenotype Analysis
# Author: Parminder Kooner

# Input and output locations
pheno_file <- "data/pheno_final.csv"
figures_dir <- "figures"
results_dir <- "results"

# Create output directories
dir.create(figures_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(results_dir, showWarnings = FALSE, recursive = TRUE)

# Read phenotype data

pheno <- read.csv(
  pheno_file,
  stringsAsFactors = FALSE
)

# Continuous-variable summary statistics

summary_stats <- data.frame(
  Variable = c(
    "Triglycerides",
    "Age",
    "BMI",
    "Weight"
  ),
  Mean = c(
    mean(pheno$TG, na.rm = TRUE),
    mean(pheno$V1AGE01, na.rm = TRUE),
    mean(pheno$BMI01, na.rm = TRUE),
    mean(pheno$ANTA04, na.rm = TRUE)
  ),
  SD = c(
    sd(pheno$TG, na.rm = TRUE),
    sd(pheno$V1AGE01, na.rm = TRUE),
    sd(pheno$BMI01, na.rm = TRUE),
    sd(pheno$ANTA04, na.rm = TRUE)
  )
)

print(summary_stats)

write.csv(
  summary_stats,
  "results/phenotype_summary_statistics.csv",
  row.names = FALSE
)

# Categorical-variable summaries

cat("\nSex distribution:\n")
print(table(pheno$SEX, useNA = "ifany"))
print(prop.table(table(pheno$SEX)))

cat("\nSmoking distribution:\n")
print(table(pheno$CURSMK, useNA = "ifany"))
print(prop.table(table(pheno$CURSMK)))

# Triglyceride distribution

png(
  "figures/triglyceride_distribution.png",
  width = 1200,
  height = 800,
  res = 150
)

par(mfrow = c(2, 2))

hist(
  pheno$TG,
  main = "Histogram of Triglyceride Levels",
  xlab = "Triglycerides (mg/dL)"
)

plot(
  density(pheno$TG, na.rm = TRUE),
  main = "Density Plot of Triglyceride Levels",
  xlab = "Triglycerides (mg/dL)"
)

qqnorm(
  pheno$TG,
  main = "Q-Q Plot of Triglyceride Levels"
)
qqline(pheno$TG)

boxplot(
  pheno$TG,
  main = "Boxplot of Triglyceride Levels",
  ylab = "Triglycerides (mg/dL)"
)

dev.off()

# BMI distribution

png(
  "figures/bmi_distribution.png",
  width = 1200,
  height = 800,
  res = 150
)

par(mfrow = c(2, 2))

hist(
  pheno$BMI01,
  main = "Histogram of BMI",
  xlab = "BMI (kg/m²)"
)

plot(
  density(pheno$BMI01, na.rm = TRUE),
  main = "Density Plot of BMI",
  xlab = "BMI (kg/m²)"
)

qqnorm(
  pheno$BMI01,
  main = "Q-Q Plot of BMI"
)
qqline(pheno$BMI01)

boxplot(
  pheno$BMI01,
  main = "Boxplot of BMI",
  ylab = "BMI (kg/m²)"
)

dev.off()

# Shapiro-Wilk normality tests

cat("\nShapiro-Wilk test for triglycerides:\n")
print(
  shapiro.test(
    na.omit(pheno$TG)
  )
)

cat("\nShapiro-Wilk test for BMI:\n")
print(
  shapiro.test(
    na.omit(pheno$BMI01)
  )
)
