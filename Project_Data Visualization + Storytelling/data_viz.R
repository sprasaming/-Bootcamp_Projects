# install.packages(
#   c("tidyverse", "patchwork", "lubridate")
# )

library(tidyverse)
library(patchwork)
library(lubridate)

d <- "2022-10-01"

d <- as.Date(d)

## convert different formats into date
"29 May, 2022"
"2022, May 29"
"29-05-2022"

d <- c("29 May, 2022", 
       "09 Sep, 1988",
       "15 Aug, 2021")

## create dataframe
df <- tribble(
  ~id, ~date,
  1, "2022/09/09",
  2, "2021/05/31",
  3, "2020/08/25"
)

df %>%
  mutate(date = ymd(date),
         day = day(date),
         month = month(date, label=T),
         year =year(date),
         wday = wday(date, label=T))

## ggplot => 2D grammar of graphic
## date mapping geom

## histogram + density
ggplot(data = mtcars, 
       mapping = aes(x = mpg)) +
  geom_histogram(bins=10)

ggplot(data = mtcars, 
       mapping = aes(x = mpg)) +
  geom_density()

base <- ggplot(data = mtcars, 
       mapping = aes(x = mpg))

## simplified version
ggplot(mtcars, 
       aes(mpg)) +
  geom_histogram(bins=10)

## boxplot
ggplot(mtcars, aes(mpg)) +
  geom_boxplot()

mtcars %>%
  summarise(
    min_mpg = min(mpg),
    max_mpg = max(mpg),
    q1 = quantile(mpg, 0.25),
    q2 = quantile(mpg, 0.5),
    q3 = quantile(mpg, 0.75)
  )

## 15 October 9am - 4.30pm

## one variable, discret/ factor
m <- mtcars %>%
  tibble() %>%
  mutate(am = factor(if_else(am==0, "Auto", "Manual")))

## qualitative data
m %>%
  count(am) %>%
  mutate(pct = n/sum(n))

ggplot(m, aes(am)) +
  geom_bar()

### EDA => Exploratory Data Analysis
### Numerical vs. Visual

## Two variables
## Scatter Plot

ggplot(m, aes(wt, mpg)) +
  geom_point()

ggplot(m, aes(wt, mpg)) +
  geom_smooth(method = "lm")

## change setting in ggplot
ggplot(m, aes(wt, mpg)) +
  geom_point(color = "red", 
             size  = 5,
             alpha = 0.8,
             shape = "+") +
  geom_smooth(method = "lm", 
              color="black", 
              fill="red", se=F)

## setting vs. mapping 
ggplot(m, aes(wt, mpg)) +
  geom_point(size= 6, 
             alpha=0.5, 
             mapping = aes(color = hp))

m <- m %>%
  mutate(cyl = factor(cyl))

ggplot(m, aes(wt, mpg)) +
  geom_point(size= 6, 
             alpha=0.5, 
             mapping = aes(color = cyl))

## prep data
m %>%
  select(wt, mpg, hp) %>%
  mutate(hp_segment = case_when(
    hp < 100 ~ "low",
    hp < 200 ~ "medium",
    TRUE ~ "high"
  )) %>% 
  mutate(hp_segment = factor(
      hp_segment,
      labels = c("low", "medium", "high"),
      levels = c("low", "medium", "high"),
      ordered = TRUE) ) %>%
  ggplot(mapping = aes(wt, mpg, 
                       color=hp_segment)) +
    geom_point(size=4, alpha=0.8) +
    scale_color_manual(values = c("red",
                                  "gold",
                                  "blue"))

## BREAK 10 minutes
## See you at 10:49am

ggplot(m, aes(x=am, y=mpg)) +
  geom_boxplot()

ggplot(m, aes(x=am, y=mpg)) +
  geom_violin() +
  geom_jitter(width=0.05)

ggplot(m, aes(x=am, y=mpg)) +
  geom_jitter(height = 0.05)

## diamonds exploration
ggplot(diamonds, aes(cut, 
                     fill=color)) +
  geom_bar() +
  theme_minimal()

set.seed(42)
ggplot(sample_n(diamonds, 1000), 
       aes(carat, price, color=cut)) +
  geom_point(alpha=0.5) +
  geom_smooth(method="lm", se=F) +
  theme_minimal() +
  facet_wrap(~ cut, ncol=5)

## facet grid

set.seed(25)
diamonds %>%
  sample_n(10000) %>%
  ggplot( aes(carat, price)) +
  geom_point(alpha=0.4) +
  geom_smooth() +
  theme_minimal() +
  facet_grid(cut ~ color)

## color
ggplot(diamonds, aes(price)) +
  geom_histogram(fill="#146ae3",
                 bins=100) +
  theme_minimal()

set.seed(42)
ggplot(sample_n(diamonds, 1000), aes(carat, price, color=cut)) +
  geom_point() +
  theme_minimal() +
  scale_color_brewer(type = "qual", palette = 3)

## available themes that can be used for free
# install.packages("ggthemes")
library(ggthemes)
library(tidyverse)

ggplot(sample_n(diamonds, 1000), aes(carat, price, color=cut)) +
  geom_point() +
  theme_economist() 

p1 <- ggplot(mtcars, aes(hp)) + geom_histogram(bins=10)
p2 <- ggplot(mtcars, aes(mpg)) + geom_density()
p3 <- ggplot(diamonds, aes(cut, fill=cut)) + geom_bar()

library(patchwork)

( p1 + p2 ) / p3

p1 / (p2 + p3)


## ggplot shortcut
## qplot()

ggplot(mtcars, aes(wt, hp)) +
  geom_point()

qplot(wt, hp, data=mtcars)
qplot(hp, data=mtcars, bins=10)
qplot(hp, data=mtcars, geom="density")
qplot(mpg, data=mtcars, geom="boxplot")
qplot(factor(am), mpg, data=mtcars, geom="boxplot")

qplot(wt, hp, data=mtcars) +
  qplot(wt, hp, data=mtcars, geom="smooth")














