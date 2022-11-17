## get working directory

getwd()

## library tidyverse

library(tidyverse)

##basic plot (base R)

hist(mtcars$mpg)

## Analyzing horse power
## Histogram - one Quantitative variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)

str(mtcars)
mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto","Manual"))


## Bar plot - One Quanlitative variable
barplot(table(mtcars$am))

## Box Plot 
boxplot(mtcars$hp)
fivenum(mtcars$hp)
min(mtcars$hp)
quantile(mtcars$hp, probs =c(.25, .5, .75))
max(mtcars$hp)

## Whisker Calculator
Q3 <- quantile(mtcars$mp, probs = .75)
Q1 <- quantile(mtcars$mp, probs = .25)
IQR_hp <- Q3 - Q1
IQR_hp

Q3 + 1.5*IQR_hp
Q1 - 1.5*IQR_hp

boxplot.stats(mtcars$hp, coef = 1.5)

## filter out outliers
mtcars_no_out <- mtcars %>%
  filter(hp <335)

boxplot(mtcars_no_out$hp)

## Box plot 2 variables
## Qualitative x Quantitative

data(mtcars)

mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto","Manual"))

boxplot(mpg ~ am, data = mtcars,
        col = c("gold","salmon"))

## Scatter Plot
## 2x Quantitative
plot(mtcars$hp, mtcars$mpg, pch = 16, 
     col ="salmon",
     main = "Relatonship between HP and MPG",
     xlab = "Horse Power",
     ylab = "Miles Per Gallon")


cor(mtcars$hp, mtcars$mpg)
lm(mpg ~ hp, data = mtcars)








