## Put comments here that give an overall description of what your functions do

## Write a short comment describing this function
# This function returns a list of matrix functions
# $set(y)         : using the <<- operator, this function
#                   caches the matrix data and clears the
#                   cached inverse of the matrix
# $get()          : gets the matrix data
# $setmatrixinv() : using the <<- operator, this function
#                   caches the inverse of the matrix
# $getmatrixinv() : gets the cached inverse of the matrix
#
makeCacheMatrix <- function(x = matrix()) 
{
     matrixinv <- NULL
     set <- function(y)
     {
          x <<- y
          matrixinv <<- NULL
     }
     get <- function() x
     setmatrixinv <- function(z) matrixinv <<- z
     getmatrixinv <- function() matrixinv
     list(set = set, get = get, setmatrixinv = setmatrixinv, getmatrixinv = getmatrixinv)
}

## Write a short comment describing this function
# 
# This function returns the inverse of x by getting it from the cache or
# by calculating it and then caching it
# This function uses the ginv function from the MASS package instead
# of the solve function (which does not work for all matrices)
cacheSolve <- function(x, ...)
{
     ## Return a matrix that is the inverse of 'x'
     # check/get for the cached inverse and return it if found
     matrixinv <- x$getmatrixinv()
     if(!is.null(matrixinv))
     {
          message("getting cached data")
          return(matrixinv)
     }
     # get the matrix data, calculate the inverse & cache the inverse
     data <- x$get()
     matrixinv <- ginv(data, ...)
     x$setmatrixinv(matrixinv)
     # return the inverse
     matrixinv
}


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
