#This file gets us started with how R works 
#This is in no way an exaustive introduction, just a sample

#Simple math
2+2
4*5
1/2
2/3


##So many Functions!
#Basic
?round
round(2/3, 3)
?abs
abs(5)
abs(-5)

## Let's think about how we put data into R
# Tons of ways to do this, but we'll only cover a couple
# Specifically, we'll show two ways to do it manually and one from external file

#First we just make a vector (one column of data) of multiple formats
#Numeric
RPE <- c(4, 8, 10, 10, 17, 15, 13)
#String
Athlete <- c('Tommmy', 'Bobby', 'Alice', 'Shania', 'Yusef', 'Annie', 'Yusef')
Athlete[7]
Athlete[7] <- 'Mary'
#Logical
Ankle_Injury <- c(F, T, F, F, F, T, F)

#Now let's turn it into a dataframe, cool!
mydata <- data.frame(Athlete, RPE, Ankle_Injury)

#Some basic ways of looking at small data
hist(RPE)
hist(mydata$RPE)
plot(mydata$Athlete, mydata$RPE)

#Some basic analyses of small data
mean(RPE)
median(RPE)
sd(RPE)
range(RPE)
max(RPE)
min(RPE)
sum(RPE)
sum(Ankle_Injury)
?scale
scale(RPE, center = T, scale = T)

#Now we will just quickly show you how to load external data into R
#Analysis of this data will be in a different presentation

#First, a Comma Separated Values file (csv)
?read.csv
athletefile <- read.csv('allsports.csv')
#index into athletefile and remove a column

#Now, read in an excel file directly...using a package!!!! Dun dun dun...
install.packages('readxl')
library(readxl)

athletefileXL <- read_excel('allsportsxl.xlsx')
