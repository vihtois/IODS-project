# Muuta IODS DATA - kansioksi
setwd("C:/DATA/Opiskelu/ODS/Data")

# -----------------------------
# Rstudio Exercise 2 (2) - OK
# -----------------------------

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
# Tarkastellaan sisältää komennoilla str ja dim
str(lrn14)
dim(lrn14)

# Tiedoston koko : 183 tietuetta, 60 muuttujaa
# Lyhyt kuvaus muuttujista : Age (ikä, kokonaisluku), Attitude (asenne, kokonaisluku),
#                            Points (pistemäärä, kokonaisluku), gender (sukupuoli, F/M),
#                            loput ykisttäisiä koetuloksia

# -----------------------------
# Rstudio Exercise 2 (3) - OK
# -----------------------------

# Luodaan analyysiä varten erillinen dataframe
install.packages("dplyr")
library(dplyr)            # select()

attach(lrn14)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

learning2014 <- filter(learning2014, Points > 0)

detach(lrn14)

dim(learning2014)
# [1] 166   7

# -----------------------------
# Rstudio Exercise 2 (4) - OK
# -----------------------------

write.csv(learning2014, file="learning2014.csv", row.names=FALSE)
xxx <- read.csv("learning2014.csv", header = TRUE)
str(xxx)
head(xxx)
