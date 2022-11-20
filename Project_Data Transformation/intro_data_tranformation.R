
## install.packages("glue")

library(tidyverse)
library(sqldf)
library(jsonlite)
library(RSQLite)
library(RPostgreSQL)
library(glue)


## Data Tranformation +50% upskill
## dplyr => grammar of data manipulation

View(mtcars)

## 5 function
## 1. select() => SELECT
## 2. filter() => WHERE
## 3. arrange() => ORDER BY
## 4. mutate() => SELECT .. AS new Column
## 5. summarise() + group_by()


select(mtcars, 1:5)

select(mtcars, 
       mpg, wt, hp, 10:11)

tibble(mtcars)


select(mtcars, starts_with("a"))
select(mtcars, ends_with("p"))
select(mtcars, contains("a"))

## select carb first and everything function
select(mtcars, carb, everything())

## Create new column
mtcars$model <- rownames(mtcars)
rownames(mtcars) <-NULL

select(mtcars, model, everything())

## Data pipeline %>%
mtcars %>% 
  select(mpg, hp ,wt) %>% 
  filter(hp < 100, wt < 2)

m1 <- mtcars %>% 
  select(mpg, hp ,wt) %>% 
  filter(hp < 100 | wt < 2) %>%
  arrange(desc(hp))

summary(m1)


## Filter Data == WHERE SQL

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(between(mpg, 25, 30))   ## between 25:30

mtcars %>%
  select(model, cyl) %>%
  filter(cyl %in% c(6,8))

mazda_data <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  filter(grepl("^Mazda", model))

## Arrange()

mtcars %>% 
  select(mpg, hp ,wt) %>% 
  filter(hp < 100 | wt < 2) %>%
  arrange(desc(hp))


## Mutate () create new column

mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(hp_segment = if_else(hp < 100, "low", "high")) %>%
  head(10)

m2 <- mtcars %>%
  select(model, mpg, hp, wt, am) %>%
  mutate(hp_segment = if_else(hp < 100, "low", "high"),
         hp_segment2 = case_when(
           hp < 100 ~ 'low',
           hp < 200 ~ 'medium',
           TRUE ~ 'high'
         ))%>%
        filter(hp >= 200)

## glimpse data structure

## str(mtcars) R standdard

glimpse(mtcars)


## help(mtcars)
## am => 0=Auto, 1=Manual

mtcars %>%
  select(model, am) %>%
  mutate(am = if_else(am == 0, "Auto","Manual")) %>%
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

write_csv(m3, "summary_mtcars.csv")
m3 <-read_csv("summary_mtcars.csv")


## data type
## Data Wrangling
## Data tranformation

mtcars %>%
    select(model, mpg, vs, am) %>%
    mutate(vs = as.factor(vs),
           am = as.factor(am)) %>%
  glimpse()

mtcars <- mtcars %>%
  mutate(vs = as.factor(vs),
         am = as.factor(am)) %>%
  glimpse()


## summarise() + group_by()

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

  
## mock up data

student <- data.frame(
  id = 1:5,
  name = c("toy", "too", "joe", "tom", "marry"),
  cid = c(1,2,2,3,2),
  uid = c(1,1,1,2,2)
  )

course <- data.frame(
  course_id = 1:3,
  course_name = c("Data", "R", "Python")
)

university <- data.frame(
  uid = c(1:2),
  u_name = c("university of Londo","Chula University")
  
)

student %>%
  left_join(course, by = c("cid"= "course_id"))


## join more than two unversity
student %>%
  left_join(course, by = c("cid" = "course_id")) %>%
  left_join(university, by ="uid") %>%
  select(student_name = name,
         course_name,
         unicersity_name = u_name)

## wide -> long format tranformations
as.data.frame(WorldPhones)


long_worldphones <- WorldPhones %>%
  as.data.frame() %>%
  rownames_to_column(var = "Year") %>%
  pivot_longer(N.Amer:Mid.Amer,
               names_to = "Region",
               values_to = "Sales")

View(long_worldphones)
  
long_worldphones %>%
    filter(Region == "Asia")

## long -> wide format
wide_data <-long_worldphones %>%
  pivot_wider(names_from = "Region",
              values_from = "Sales")

write_csv(wide_data, "wide_data.csv")


## connect sql database
## 1. SQLite
## 2. PostgreSQL Server
library(RSQLite)
library(RPostgreSQL)

## Step to connect database
## Create connection > Query > Close con

con <- dbConnect(SQLite(),"chinook.db")

dbListTables(con)
dbGetQuery(con, "
           select 
           firstname, 
           lastname,
           country 
           FROM customers
           WHERE country 
           IN('France','Austria','Belgium') ")

query01 <- "
  select * FROM artists
  JOIN albums on artists.artistid = albums.artistid
  JOIN tracks on tracks.albumid = albums.albumid
"

tracks <- dbGetQuery(con, query01)
View(tracks)


dbDisconnect(con)

## Sample data n=10
library(janitor)
tracks_clean <- clean_names(tracks)

set.seed(10)
tracks_clean %>%
    select(1:2) %>%
    sample_n(10)

## R Connect to ProstgreSQL

## Username,Password, host(server),port, dbname


con <- dbConnect(PostgreSQL(),
                 user = "zbdmxave",
                 password = "1Dhn_B9HTDhZpsukT93V6EG8ofYs8ZTE",
                 host = "rosie.db.elephantsql.com",
                 port = 5432,
                 dbname = "zbdmxave")
dbListTables(con)

course <- data.frame(
  id = 1:3,
  name = c("Data Scince", "Software", "R")
)


dbWriteTable(con, "course", course)



dbWriteTable(con, "course", data.frame(
  id = 1:5,
  course_name =c("Data", "Software", "Design", "R", "SQL")
),Row.names = FALSE)


dbListTables(con)
dbGetQuery(con, "select * from course;")

dbDisconnect(con)



