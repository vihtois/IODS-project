# Exercise 4
# ----------

# ------------------------
# Valmistelevat tehtävät
# ------------------------

install.packages("corrplot")                 )

library(MASS)
library(GGally)
library(ggplot2)
library(dplyr)       # pipe %>%
library(corrplot)

setwd("C:/DATA/Opiskelu/ODS/Exercise_4")

# ---------------------
# Exercise 4 (2) - OK
# ---------------------

data(Boston)
str(Boston)
dim(Boston)

# -----------------------
# Exercise 4 (3) - OK
# -----------------------


# - graphical overview
plot1 <- ggpairs(Boston, mapping = aes(alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20))) + ggtitle("Comparing variables against each other") 
plot1
# - summaries of the variables
summary(Boston)
# - describe and interpret the outputs
cor_matrix <- cor(Boston) %>% round(digits = 2)
print(cor_matrix)

# -----------------------
# Exercise 4 (4) - OK
# -----------------------

# - standardize => SCALE()
Boston_scaled <- scale(Boston)
summary(Boston_scaled)
# - eli standardoitu (keskiarvo 0), mutta ei ole normnalisoitu (1 ja 3 kvantiili eivät samat), vai onko SD 1
breakpoints <- quantile(Boston_scaled$crim)
Boston_scaled <- as.data.frame(Boston_scaled)
labels <- c("low", "mod_low", "mod_high", "high")
crime_cat <- cut(Boston_scaled$crim, breakpoints, include.lowest = TRUE, label = labels)
table(crime_cat)
# - nyt tulee luoda luokiteltu muuttuja standardoidusta crim-muuttujasta, kvantiilit break-pointteina
Boston_scaled <- dplyr::select(Boston_scaled, -crim)
Boston_scaled <- data.frame(Boston_scaled, crime_cat)
# - poista vanha crime rate (crim) Boston datasetistä
n <- nrow(Boston_scaled)
perc8020 <- sample(n, size = n * 0.8)
train <- Boston_scaled[perc8020,]
test <- Boston_scaled[-perc8020,]
nrow(train)
nrow(test)
# - jaa train ja test sets 80/20 (MOOC)

# -----------------------
# Exercise 4 (5) - OK
# -----------------------

lda.fit <- lda(crime_cat ~ ., data = train)
lda.fit
# - Fit LDA to train set

lda.arrows <- function(x, myscale = 0.5, arrow_heads = 0.1, color = "red", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}
classes <- as.numeric(train$crime_cat)
plot(lda.fit, dimen = 2, col = classes, pch = classes)
lda.arrows(lda.fit, myscale = 2)
# - remove the categorial crime 

# -----------------------
# Exercise 4 (6) - OK
# -----------------------

correct_classes <- test$crime_cat
test <- dplyr::select(test, -crime_cat)

lda.pred <- predict(lda.fit, newdata = test)
table(correct = correct_classes, predicted = lda.pred$class)

# - tallenna crime categories from the test set
# - remove the categorial crime variable from the test dataset
# - predict the classes with the LDA model on the test data
# - cross tabulate the results with the crime categories from the test set

# -----------------------
# Exercise 4 (7) - Not OK
# -----------------------

data(Boston)
scale(Boston)

dist_euclidean <- dist(Boston)
summary(dist_euclidean)

set.seed(610837)
km <-kmeans(dist_euclidean, centers=10)
pairs(Boston, col = km$cluster)
# kuvasta ei pysty paljon lukemaan -> korrelaatiomatriisi ?

k_max <- 10
twcss <- sapply(1:k_max, function(k){kmeans(dist_euclidean, k)$tot.withinss})
plot(1:k_max, twcss, type='b')

# - reload Boston
# - strandardize the dataset, SCALE()
# - calculate distances between observations
# - run k-means algorithm on the dataset
# - investigate what is optimal number of clusters, run algorithm again
# - visualize the clusters, pairs(), qqpairs(), where clusters are separated
# - interpret the results
