## Data TYPE 

##1.numeric
age <-32
print(age)
class(age)


##2.Character
my_name <- "Nueng"
My_university <- "RMUTP"
print(my_name)
print(My_university)
class(my_name);class(My_university)


##3.logical
result <- 1 + 1 == 2
print(result)
class(result)


##4.factor
animal <- c("dog","cat","cat","hippo")
class (animal)

animals <- factor(animal)
class (animals)
print (animals)

##5.date
time_now <- Sys.time()
class(time_now)

###-----------------------------------------

## Convert data type


## main function
## as.numric()
## as.character()
## as.logical()

x <- 100
class(x)

char_X <- as.character(x)
char_X

num_x <- as.numeric(char_X)
num_x


##logical : TRUE/FALSE


as.logical(0)
as.logical(1)

as.numeric(TRUE)
as.numeric(FALSE)


###-----------------------------------------

##data stuctures
## 1.vector
## 2.matrix
## 3.list
## 4.dataFrame




## vector 

1:10
16:25

## sequence generation
seq(from = 1, to = 100, by =5)


##help file
help("seq")



##function c.
friends <- c("David", "Mary", "Anna", "John", "William")
x
ages <- c (30, 31, 25, 29, 32) 

is_male <- c (TRUE, FALSE, FALSE, TRUE, TRUE)

## matrix
x <- 1:25
length (x)
dim(x) <- c(5,5)

m1 <- matrix(1:25, ncol=5)
m2 <- matrix(1:6, ncol=3, nrow=2, byrow=T)

##element wise computation
m2 + 100
m2 * 4

##list

my_name <- "Toy"
my_friend <- c ("wan", "Ink", "Zue")
m1 <- matrix(1:25, ncol=5)
R_is_cool <- TRUE

my_list <- list(item1 = my_name,
                item2 = my_friend,
                item3 = m1,
                item4 = R_is_cool)
my_list$item3
my_list$item4

##data frame

friends <- c("Wan", "Ink", "Toy", "Bee", "Top")

ages <- c(26, 27, 32, 31, 28)

locations <- c("New York", "London", "London", "Tokyo", "Manchester" )

Movie_lover <- c(TRUE, TRUE, FALSE, TRUE, TRUE)

df <-data.frame(friends,
           age,
           locations,
           Movie_lover)
View(df)

friends <- c("Wan", "Ink", "Toy", "Bee", "Top")

ages <- c(26, 27, 32, 31, 28)

locations <- c("New York", "London", "London", "Tokyo", "Manchester" )

Movie_lover <- c(TRUE, TRUE, FALSE, TRUE, TRUE)

#Create dataframe from list
my_list <- list (friends = friends,
                 ages = ages,
                 locations = locations,
                 movie = Movie_lover)

data.frame(my_list)





