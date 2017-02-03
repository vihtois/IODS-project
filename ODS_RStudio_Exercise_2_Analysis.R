# ===============================
# Rstudio Exercixe 2 - Analysis
# ===============================

# --------------
# Analysis (1)  
# --------------

students2014 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt",sep=",",header=TRUE)
dim(students2014)
# [1] 166   7
str(students2014)
# 'data.frame':	166 obs. of  7 variables:
# $ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
# $ age     : int  53 55 49 53 49 38 50 37 37 42 ...
# $ attitude: num  3.7 3.1 2.5 3.5 3.7 3.8 3.5 2.9 3.8 2.1 ...
# $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
# $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
# $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
# $ points  : int  25 12 24 10 22 21 21 31 24 26 ...
# YLLÄOLEVILLE : Explore the structure and the dimensions of the data and describe the dataset briefly, assuming the 
#                reader has no previous knowledge of it.

# --------------
# Analysis - 2
# --------------

install.packages("ggplot2")
library(ggplot2)

attach(students2014)

# Histogrammi miesten ja naisten lukumääristä (OK)
plot(gender, border="dark blue", col="light blue", main="Naisten ja miesten lukumäärä", xlab="Naiset (F), Miehet (M)")
summary(gender)

# Histogrammi naisten ja miesten iät (Not OK)
Nika <- subset(age, (gender == "F"))
Mika <- subset(age, (gender == "M"))
hist(Nika, col="red", breaks=c(10,20,30,40,50,60))
hist(Mika, col="blue", breaks=c(10,20,30,40,50,60))
barplot(Mika)

summary(age)

# Jakauma asenne (OK)
d <- density(students2014$attitude)
plot(d, main="Attitude distribution")
polygon(d, col="red", border="black")

# Asenteen ja arvosanojen välinen yhteys
grades <- cut(students2014$points, breaks = c(0, 11, 15, 19, 23, 27, 33), include.lowest = TRUE)
qplot(grades, attitude, data=students2014, geom="boxplot", fill=grades)

summary(students2014$attitude)

# Points

qplot(attitude, points, col = gender, data = students2014) + geom_smooth(method = "lm")

# Yleiskuva, jossa korrelaatio jakaumat etc ...


install.packages("GGally")
library(GGally)
ggpairs(students2014)
# USKOMATONTA MITÄ YHDELLÄ KOMENNOLLA SAA AIKAAN
# Ylläolevassa tarvii ainakin gender F/M luokittelun

detach(students2014)

# --------------
# Analysis - 3
# --------------

# --------------
# Analysis - 4
# --------------

# --------------
# Analysis - 5
# --------------