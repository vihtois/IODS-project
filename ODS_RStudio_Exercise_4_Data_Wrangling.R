# ODS
# Exercise 4 - Data Wrangling

# ----------------------
# Valmistelevat tehtävät
# ----------------------

setwd("C:/DATA/Opiskelu/ODS/Exercise_4")

# ------------------------
# Exercise 4 Wrangling (2)
# ------------------------

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# ------------------------
# Exercise 4 Wrangling (3)
# ------------------------

dim(hd)
str(hd)
summary(hd)

dim(gii)
str(gii)
summary(gii)

# ------------------------
# Exercise 4 Wrangling (4)
# ------------------------

colnames(hd) <- c("HDIrank","country","HDI","LifeExp","ExpEducYears","MeanEducYears","GNI","GNI2")
colnames(gii) <- c("GIIrank","country","GII","MatMor","AdoBirth","RepInParl","PopSecEduF","PopSecEduM","LabForRateF","LabForRateM")

# ------------------------
# Exercise 4 Wrangling (5)
# ------------------------

gii <- mutate(gii, SecEduRate = PopSecEduF / PopSecEduM)
gii <- mutate(gii, LabForRate = LabForRateF / LabForRateM)

# ------------------------
# Exercise 4 Wrangling (6)
# ------------------------

join_by=c("country")
human <- inner_join(hd, gii, by=join_by)
