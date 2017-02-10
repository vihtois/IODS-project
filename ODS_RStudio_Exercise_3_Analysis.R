# Open Data Science - Exercise 3
# 09.02.2017
# Ismo Vihtola

# Valmistelevat tehtävät
# ----------------------

setwd("C:/DATA/Opiskelu/ODS/Exercise_3")
# Aja ODS_RStudio_Exercise_2_Data_Wrangling_5_points
# -> alc dataframe

# --------------------
# Analysis 3 (5) koodi
# --------------------

alc
model35 <- lm(high_use ~ age + goout + absences + G3, data = alc)
summary(model35)

# - age ja G3 kertoimet lähellä 0

model35 <- lm(high_use ~ goout + absences + G3, data = alc)
summary(model35)

model35 <- lm(high_use ~ goout + absences, data = alc)
summary(model35)

# - näyttäisi OK, TÄHÄN ANALYYSIÄ

# compute odds ratios (OR)
OR <- coef(model35) %>% exp

# compute confidence intervals (CI)
confint(model35)
CI <- confint(model35) %>% exp

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

JA TÄHÄN JOTAIN ANALYYSIÄ

# --------------------
# Analysis 3 (6) koodi
# --------------------

2*2 cross tab