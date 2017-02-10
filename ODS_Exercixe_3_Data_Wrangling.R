# Open Data Science - Exercise 3
# 09.02.2017
# Ismo Vihtola

# Valmistelevat tehtävät
# ----------------------

setwd("C:/DATA/Opiskelu/ODS/Exercise_3")

library(dplyr)

# -----------------------------
# Rstudio Exercise 3 (3) - OK
# -----------------------------

student_mat <- read.table("student-mat.csv", sep=";", header=TRUE)
str(student_mat)
dim(student_mat)

student_por <- read.table("student-por.csv", sep=";", header=TRUE)
str(student_por)
dim(student_por)

# -----------------------------
# Rstudio Exercise 3 (4) - OK
# -----------------------------

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(student_mat, student_por, by = join_by)
# math_por <- inner_join(math, por, by = join_by, suffix=c(".math",".por"))
str(math_por)
dim(math_por)

# -----------------------------
# Rstudio Exercise 3 (5) - OK
# -----------------------------

alc <- select(math_por, one_of(join_by))

# MOOC 3-3 valmis script
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]


# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- column_name
  }
}

# -----------------------------
# Rstudio Exercise 3 (6) - OK
# -----------------------------

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
dim(alc)

# -----------------------------
# Rstudio Exercise 3 (7) - OK
# -----------------------------

glimpse(alc)
