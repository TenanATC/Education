#This file is used to review some general statistical concepts
#And how they can be implemented within R
#This is in no way exhaustive... just examples

#First We'll load the packages used for this walk-through
library(dplyr)
library(ggfortify)
library(fitdistrplus)


#Second, let's review (probably) the most important thing about statistics: Distributions
ggdistribution(dnorm, seq(-10, 10, 0.1), mean = 0, sd = 1, fill = 'blue') + ylim(0,.45)
ggdistribution(dnorm, seq(-10, 10, 0.1), mean = 0, sd = 2, fill = 'blue') + ylim(0,.45)
ggdistribution(dnorm, seq(-10, 10, 0.1), mean = 1, sd = 1, fill = 'blue') + ylim(0,.45)
ggdistribution(dnorm, seq(-10, 10, 0.1), mean = -1, sd = 2, fill = 'blue') + ylim(0,.45)

ggdistribution(dpois, x=0:25, lambda=3, fill = 'blue') + ylim(0,.45)
ggdistribution(dpois, x=0:25, lambda=2, fill = 'blue') + ylim(0,.45)
ggdistribution(dpois, x=0:25, lambda=1, fill = 'blue') + ylim(0,.45)
ggdistribution(dpois, x=0:25, lambda=6, fill = 'blue') + ylim(0,.45)

ggdistribution(dt, seq(-10, 10, 0.1), df=1, fill = 'blue') + ylim(0,.45)
ggdistribution(dt, seq(-10, 10, 0.1), df=2, fill = 'blue') + ylim(0,.45)
ggdistribution(dt, seq(-10, 10, 0.1), df=5, fill = 'blue') + ylim(0,.45)
ggdistribution(dt, seq(-10, 10, 0.1), df=10, fill = 'blue') + ylim(0,.45)
ggdistribution(dt, seq(-10, 10, 0.1), df=12, fill = 'blue') + ylim(0,.45)

hist(runif(100, min = 0, max = 55))
hist(runif(1000, min = 0, max = 55))
hist(runif(10000, min = 0, max = 55))
hist(runif(100000, min = 0, max = 55))

hist(rnorm(10, mean = 0, sd= 1))
hist(rnorm(20, mean = 0, sd= 1))
hist(rnorm(50, mean = 0, sd= 1))
hist(rnorm(100, mean = 0, sd= 1))
hist(rnorm(1000, mean = 0, sd= 1))


#Now we'll read in some "real data" to do some example statistics
allsport_dat <- read.csv('allsports.csv')
allsport_dat$X <- NULL

#First thing we should always do is "look at the data"
hist(allsport_dat$age)
hist(allsport_dat$QuadHamRatio)

femsoc <- filter(allsport_dat, sport== 'soccer' & gender== 'W') 
hist(femsoc$QuadHamRatio)
#Hmm, not 'normal', let's see what a statistical test says
shapiro.test(femsoc$QuadHamRatio)
shapiro.test(allsport_dat$QuadHamRatio)

descdist(allsport_dat$QuadHamRatio, graph = F)
descdist(femsoc$QuadHamRatio, graph = F)
#so what would normal distribution statistics look like?
descdist(rnorm(10000), graph = F)

#Alright, we get it. We can't assume a normal distribution what if we want to analyze this data?
#First, we, again need to visualize things
ggplot(allsport_dat, aes(x= sport,y = QuadHamRatio)) + geom_boxplot()
ggplot(allsport_dat, aes(x= gender,y = QuadHamRatio)) + geom_boxplot()
#more informative
ggplot(allsport_dat, aes(x= sport,y = QuadHamRatio)) + geom_boxplot(alpha = 0) +geom_jitter()
ggplot(allsport_dat, aes(x= gender,y = QuadHamRatio)) + geom_boxplot(alpha = 0) +geom_jitter()

#Finally, if we want to think about a traditional statistical test to examine group differences
#We can run some basic analyses which will show how parametric/non-parametric approaches 
#May or may not differ
t.test(QuadHamRatio ~ gender, data=allsport_dat)
wilcox.test(QuadHamRatio ~ gender, data = allsport_dat)

aov(lm(QuadHamRatio ~ sport, data = allsport_dat))
TukeyHSD(aov(lm(QuadHamRatio ~ sport, data = allsport_dat)))
