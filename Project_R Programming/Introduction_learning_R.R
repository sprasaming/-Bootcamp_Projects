## create new variables

income <- 6000
expense <- 3200
saving <- income - expense

## remove variables

rm(saving)

#### Print characters (string)

## print hello world

print ("hello world")
print ('hello world')

## there are other function too

cat("R is awesome!")

## define your own function

my_sum <- function(num1, num2=10){
  num1 + num2
}

## test function
my_sum(20,0)


## call function in library
library(glue)

my_names <- "Nueng"
my_ages <- 31

glue("Hello my name is {my_names}. This year I'm {my_ages} years old")


##hello()

hello <- function (user_name){
  glue("Hello! {user_name}")
}


#### data type

#numric
class(100)

#character
class("Hello World")

#logical
class(TRUE) #FALSE

#### data type
my_ages <- 31
class(my_ages)

fav_book <- "Business made simple"
class(fav_book)

movie_lover <- TRUE
class(movie_lover)

puppy <- c("cat", "dog", "dog", "cat", "cat")
class (puppy)

puppy <- as.factor(puppy)

today <- as.Date("2021-09-04")

## data structures
## vector, matrix, list, dataframe

# 1. vector
1:10
89:205

seq(from=1, to=100, by=4)

my_friends <- c ("Toy", "Aan", "YOS", "Ink", "Top")
ages <- c (33, 33, 30, 29, 28)
movie_lover <- c (T, F, T, F, T)

# 2. matrix
m1 <- matrix(1:25,ncol = 5 , byrow = T)

ncol(m1)
nrow(m1)
dim(m1)

# 3. list
customer_data <- list(
  id = 1,
  name = "David",
  location = "London",
  language = "English"
)

customer_data$name
customer_data[[2]]


customer_data <- list(
  customer_01 = list(
    name = "David",
    location = "London",
    manchester_fan = TRUE
  ),
  customer_02 = list(
    name = "Kego",
    location = "Tokyo"
  ),
  customer_03 = list(
    name = "Anna",
    location = "Washington",
    movie_lover = TRUE,
    visit_bank = TRUE,
    account_blance = 20000
  )  
)

customer_data[[3]][[4]]


## DataFrame
my_friends <- c ("Toy", "Aan", "YOS", "Ink", "Top")
ages <- c (33, 33, 30, 29, 28)
movie_lover <- c (T, F, T, F, T)

df <- data.frame(id = 1:5, 
                 my_friends, 
                 ages, 
                 movie_lover)

View(df)

## write .csv file
write.csv(df,"friend.csv", row.names = FALSE)


## read .csv file

friend <- read.csv("friend.csv")

class(friend)

# subset dataframe
# subset = extract data
friend[1:2, 2:3]
friend[1:4, 1:4]
friend[1:4, ]
friend[ c(1,3,4), ]
friend[ , "my_friends"]
friend[ , c("my_friends", "ages")]

friend$ages < 30

friend[ friend$ages >= 30, ]
friend [ c(F,F,F,T,T), ]

friend[ friend$movie_lover , ]
friend[ !friend$movie_lover , ]

new_friend <- data.frame(
  id = 6:7,
  my_friends = c("Ball", "Wann"),
  ages = c(32, 26),
  movie_lover = c(T, T)
)

# row bind
all_friends <- rbind(friend, new_friend)


# add column
all_friends$correct_age <- all_friends$ages - 1

# remove Column
all_friends$ages <- NULL

# rename column  #R start index 1 ,Python start index 0   
names(all_friends)[2] <- "name"

mini_friends <- all_friends[ -c(3,4), ]

## Control Flow

## 1. if

score <- 55

if (score >= 80) {
  print("Passed")
} else {
  print("Failed")
}



check_grade <- function(score){
  if (score >= 80) {
    print("A")
  } else {
    print("Failed")
  }
}

score <-90
ifelse(score >=80, "Passed","Failed")

check_grade_2 <- function(score){
  ifelse(score >=80, "Passed","Failed")
}

##  if
## A,B,C,D,F

check_grade <- function(score){
  if (score >= 80) {
    print("A")
  } else if(score >= 70) {
    print("B")
  } else if(score >= 60) {
    print("C") 
  } else if(score >= 50) {
    print("D")
  } else {
    print("F")
  }
}

## 2. for loop

numbers <- c(10, 15, 20, 50)

for (num in numbers){
  print (num*2)
}


##-----------------------------
numbers*2 #element wise computation

friends<- c("Toy", "Aan", "Wann")

for (friend in friends){
  print(paste("Hello! ", friend))
}


paste("Hello! ", friends)



## 3. while loop
while (TRUE){
  #do someting
}


x <- 0

while (x < 10 ){
  print("hello!")
  x <- x + 1
}



## check username & password

check_in <- function () {
  user_input <- readline( "What is your username: ")
  user_pw <- readline( "What is your password: ")
  
  sys_un <- "toy"
  sys_pw <- "123456"

  if(user_input == sys_un & user_pw == sys_pw ) {
    print ("Log in Suscessfully")
  } else {
    print ("Please check your username & password")
  }
}

## ==================================

check_in <- function () {
  user_input <- readline( "What is your username: ")
  user_pw <- readline( "What is your password: ")
  
  sys_un <- c("toy","ann","wan")
  sys_pw <- "123456"
  
  if(user_input %in% sys_un & user_pw == sys_pw ) {
    print ("Log in Suscessfully")
  } else {
    print ("Please check your username & password")
  }
}










