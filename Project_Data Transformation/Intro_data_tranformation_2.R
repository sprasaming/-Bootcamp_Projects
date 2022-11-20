## install.packages("glue")

library(tidyverse)
library(sqldf)
library(jsonlite)
library(RSQLite)
library(RPostgreSQL)
library(glue)

View(mtcars)

## 5 function
## 1. select() => SELECT
## 2. filter() => WHERE
## 3. arrange() => ORDER BY
## 4. mutate() => SELECT .. AS new Column
## 5. summarise() + group_by()

## 1. select carb first and everything function

select(mtcars, 1:5)

select(mtcars, 
       mpg, wt, hp, 10:11)

select(mtcars, starts_with("a"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))
select(mtcars, carb, everything())

tibble(mtcars)

## Create new column

mtcars$model <- rownames(mtcars)
head(mtcars)
rownames(mtcars) <- NULL

mtcars <- select(mtcars, model, everything())

## Data Pipeline %>% (pipe operator)

m1 <- mtcars %>%
  select(model, mpg, hp, wt) %>%
  filter(hp <100 | wt <2) %>%
  arrange(desc(hp))
  
summary(m1)

## 2. Filter Data == WHERE SQL

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(mpg, 25, 30)) 


mtcars %>%
  select(model, cyl) %>%
  filter(cyl %in% c(6,8))


mazda_data <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(grepl("^Mazda", model))


## 4. Mutate () create new column
## 3. arrange

m2 <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(hp_segment = if_else(hp <100, "low","high"),
         hp_segment2 = case_when(
           hp < 100 ~ 'low',
           hp < 200 ~ 'medium',
           TRUE  ~ 'high'
         )) 

## glimpse data structure
glimpse(mtcars)


## help(mtcars) Check data frame 

## am => 0=Auto, 1=Manual
mtcars %>%
  select(model, am) %>%
  mutate(am = if_else(am == 0, "Auto", "Manual")%>%
           count(am)


mtcars %>%
  count(cyl)


mtcars <- mtcars %>%
  mutate(am = if_else(am == 0, "Auto","Manual"),
         vs = if_else(vs == 0, "V-shaped","straight"))

View(mtcars)


## Count

mtcars %>%
  count(am)

mtcars %>%
  count(am, vs) ## 2*2 = 4

nrow(mtcars)
ncol(mtcars)
dim(mtcars)
glimpse(mtcars)


m3 <- mtcars %>%
  count(am, vs) %>%  
  mutate(percent = n/ nrow(mtcars))

## Read write CSV Files
write_csv(m3,"summary_mtcars.csv")

## Read write CSV Files
m3 <- read_csv("summary_mtcars.csv")

## Change data types

mtcars <- mtcars %>%
  mutate(vs = as.factor(vs),
         am = as.factor(am)) 

View(mtcars)

## Data Wrangling
## Data Tranformation

## 5. summarise() + group_by()

mtcars %>%
  summarise(
    avg_mpg = mean(mpg),
    sum_mpg = sum(mpg),
    min_mpg = min(mpg),
    max_mpg = max(mpg),
    var_mpg = var(mpg),
    sd_mpg = sd(mpg),
    median_mpg = median(mpg),
    n = n() 
  )


result <- mtcars %>%
  group_by(am, vs)%>%
  summarise(
    avg_mpg = mean(mpg),
    sum_mpg = sum(mpg),
    min_mpg = min(mpg),
    max_mpg = max(mpg),
    var_mpg = var(mpg),
    sd_mpg = sd(mpg),
    median_mpg = median(mpg),
    n = n() 
  )

write_csv(result,"result.csv")


## JOIN TABLES

band_members
band_instruments

inner_join(band_members,
           band_instruments,
           by = "name")

inner_join(band_members,
           band_instruments,
           by = "name")

right_join(band_members,
           band_instruments,
           by = "name")

full_join(band_members,
          band_instruments,
          by = "name")

## refactor code

band_members %>%
  full_join(band_instruments,
            by="name") %>%
  filter(name %in% c("John", "Paul")) %>%
  mutate(hello = "ok")


## library load package

library(nycflights13)

flights
View(flights)
glimpse(flights)


flights %>%
  filter(month == 9) %>%
  count(origin, dest)


## carries most flights
## in march - may 2013
## origin jfk

df <- flights %>%
  filter( origin == "JFK" & 
            month %in% c(3,4,5)) %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  left_join(airlines,by="carrier")

write_csv(df, "requested_data.csv")


