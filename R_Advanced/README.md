3 Vectors
 
df1 <- data.frame(x = 1:3, y = letters[1:3])
typeof(df1)
#> [1] "list"

Tibble = modernization of Data Frames
5 Control flow
grade <- function(x) {
  if (x > 90) {
    "A"
  } else if (x > 80) {
    "B"
  } else if (x > 50) {
    "C"
  } else {
    "F"
  }
}

Functional programming
 
9 functionals
A functional is a function that takes a function as an input and returns a vector as output. Here’s a simple functional: it calls the function provided as input with 1000 random uniform numbers.
randomise <- function(f) f(runif(1e3))
randomise(mean)
#> [1] 0.506
randomise(mean)
#> [1] 0.501
randomise(sum)
#> [1] 489
Map : Apply a function to each element of a vector
 
pair <- function(x) c(x, x)
map_dbl(1:2, pair)

Anonymous functions and shortcuts
map_dbl(mtcars, function(x) length(unique(x)))
#>  mpg  cyl disp   hp drat   wt qsec   vs   am gear carb 
#>   25    3   27   22   22   29   30    2    2    3    6
Anonymous functions are very useful, but the syntax is verbose. So purrr supports a special shortcut:
map_dbl(mtcars, ~ length(unique(.x)))
#>  mpg  cyl disp   hp drat   wt qsec   vs   am gear carb 
#>   25    3   27   22   22   29   30    2    2    3    6

Purrr style
This creates a list of three data frames: the cars with 4, 6, and 8 cylinders respectively.
by_cyl <- split(mtcars, mtcars$cyl)
Now imagine we want to fit a linear model, then extract the second coefficient (i.e. the slope). The following code shows how you might do that with purrr:
by_cyl %>% 
  map(~ lm(mpg ~ wt, data = .x)) %>% 
  map(coef) %>% 
  map_dbl(2)
#>     4     6     8 
#> -5.65 -2.78 -2.19

Reduce family
reduce() takes a vector of length n and produces a vector of length 1 by calling a function with a pair of values at a time: reduce(1:4, f) is equivalent to f(f(f(1, 2), 3), 4).
 
reduce() is a useful way to generalise a function that works with two inputs (a binary function) to work with any number of inputs. Imagine you have a list of numeric vectors, and you want to find the values that occur in every element. First we generate some sample data:
l <- map(1:4, ~ sample(1:10, 15, replace = T))
str(l)
#> List of 4
#>  $ : int [1:15] 7 1 8 8 3 8 2 4 7 10 ...
#>  $ : int [1:15] 3 1 10 2 5 2 9 8 5 4 ...
#>  $ : int [1:15] 6 10 9 5 6 7 8 6 10 8 ...
#>  $ : int [1:15] 9 8 6 4 4 5 2 9 9 6 ...
To solve this challenge we need to use intersect() repeatedly:
out <- l[[1]]
out <- intersect(out, l[[2]])
out <- intersect(out, l[[3]])
out <- intersect(out, l[[4]])
out
#> [1] 8 4
reduce() automates this solution for us, so we can write:
reduce(l, intersect)
#> [1] 8 4
10 Function factories
A function factory is a function that makes functions.
power1 <- function(exp) {
  function(x) {
    x ^ exp
  }
}

square <- power1(2)
cube <- power1(3)


