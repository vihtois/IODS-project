
# ------------------------
# Exercise 5 Wrangling (1)
# ------------------------

# haetaan webistä yllä tehtyjä vastaava tiedosto, jossa muuttujien nimet ohjeen mukaiset
human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", stringsAsFactors = F)

human <- mutate(human, GNIX = str_replace(GNI, pattern=",", replace ="") %>% as.numeric)

# ------------------------
# Exercise 5 Wrangling (2)
# ------------------------

keep_col <- c("Country","Edu2.FM","Labo.FM","Edu.Exp","Life.Exp","GNI","Mat.Mor","Ado.Birth","Parli.F")
human <- select(human, one_of(keep_col))

# ------------------------
# Exercise 5 Wrangling (3)
# ------------------------

complete.cases(human)
human <- data.frame(human, comp = complete.cases(human))
# human <- data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, comp == TRUE)

# ------------------------
# Exercise 5 Wrangling (4) 
# ------------------------

# poistettavat rivit 155 - 162
human <- human[-c(156:162), ]

# ------------------------
# Exercise 5 Wrangling (5) - Not OK
# ------------------------

human2 <- human[,-1]
rownames(human2) <- human[,1]

human <- as.data.frame(human2)
dim(human)
