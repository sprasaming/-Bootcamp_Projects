## ggplot2
## library tidyverse
library(tidyverse)

## First plot

ggplot(data = mtcars, mapping = aes(x = hp ,y = mpg)) + 
  geom_point() +
  geom_smooth() +
  geom_rug()

ggplot(mtcars, aes(hp, mpg))+
  geom_point(size = 3, col = "blue", alpha = 0.2)

ggplot(mtcars, aes(hp))+
  geom_histogram(bins = 10 ,fill ="red", alpha = 0.2)

ggplot(mtcars, aes(hp))+
  geom_boxplot()

p <- ggplot(mtcars, aes(hp))
p + geom_histogram(bins=10)
p + geom_density()
p + geom_boxplot()

## Box Plot by groups
diamonds %>%
  count(cut)

ggplot(diamonds, aes(cut))+
  geom_bar(fill = "lightblue")

diamonds %>%
  count(color)

ggplot(diamonds, mapping = aes(cut,fill=color))+
  geom_bar(position = "dodge")

ggplot(diamonds, mapping = aes(cut,fill=color))+
  geom_bar(position = "fill")


## scatter plot
## Random sample

set.seed(99)
small_diamonds <- sample_n(diamonds, 5000)

ggplot(small_diamonds, aes(carat, price))+
  geom_point()


## FACET : Small multiples

ggplot(small_diamonds, aes(carat, price))+
  geom_point()+
  geom_smooth(method = "lm", col ="red")+
  facet_wrap(~color, ncol=2)+
  theme_minimal()+
  labs(title = "Relationship between carat and price by color",
       x = "Carat",
       y = "Price USD",
       caption = "Source : Diamond from ggpolt2 package")

## Final example
ggplot(small_diamonds, aes(carat, price, col=cut))+
  geom_point(size = 3, alpha = 0.5)+
  facet_wrap(~color, ncol=2)+
  theme_minimal()


