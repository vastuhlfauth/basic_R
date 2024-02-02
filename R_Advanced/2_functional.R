randomise <- function(f) f(runif(1e3))

map_dbl(mtcars, function(x) length(unique(x)))


library(rlang)

square <- function(x) {
  x ^ exp
  }