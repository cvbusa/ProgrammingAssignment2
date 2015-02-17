source("./cachematrix.R")

## check results
library("MASS")
#
x <-c(1:16)
x <-matrix(x, nrow = 4, ncol = 4, byrow = FALSE)
x
## create a list of functions in xx that are specific for matrix x
xx <-makeCacheMatrix(x)
## run cacheSolve using xx to get the cache of the inverse of x or to calculate/cache the inverse of x
cacheSolve(xx)
## run cacheSolve using xx again to retreive the cached inverse of x, skipping the re-calculation
cacheSolve(xx)
## run $set() function to reset x and clear the cached inverse of x
xx$set(x)
## run cacheSolve using xx and this time the inverse of x is calculated/cached
cacheSolve(xx)

#
x <-c(0,2,1,0)
x <-matrix(x, nrow = 2, ncol = 2, byrow = TRUE)
x
xx <-makeCacheMatrix(x)
cacheSolve(xx)
cacheSolve(xx)
xx$set(x)
cacheSolve(xx)
xx$set(t(x))
cacheSolve(xx)
cacheSolve(xx)

my_matrix = matrix( c(1, 1, 3, 1), nrow=2, ncol=2)
x <- makeCacheMatrix(my_matrix)
x$get()
cacheSolve(x)
cacheSolve(x)

my_matrix = matrix( c(1, 1, 2, 4, 1, 3, 2, 2, 1), nrow=3, ncol=3)
x$set(my_matrix)
x$get()
cacheSolve(x)
cacheSolve(x)
