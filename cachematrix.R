## Put comments here that give an overall description of what your functions do

## Write a short comment describing this function

# This function returns a list of matrix functions
# $set(y)          : using the <<- operator, this function caches new matrix data and
#                    clears the cached inverse of the matrix in the global environment
# $get()           : gets the matrix data from the global environment
# $setmatrixinv(z) : using the <<- operator, this function
#                    caches the inverse of the matrix to the global environment
# $getmatrixinv()  : gets the cached inverse of the matrix from the global environment

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

# This function returns the inverse of matrix x by getting it from the cache
# or by calculating it and then caching it to the global environment
# This function uses the ginv function from the MASS package instead
# of the solve function (which does not work for all matrices)

cacheSolve <- function(x, ...)
{
     ## Return a matrix that is the inverse of 'x'
     # check for the cached inverse and return it if found
     matrixinv <- x$getmatrixinv()
     if(!is.null(matrixinv))
     {
          message("getting cached data")
          return(matrixinv)
     }
     # get the matrix data from the cache
     data <- x$get()
     # calculates the inverse of the matrix using the ginv function
     ifelse(!exists("ginv"),{require(MASS);library(MASS)},TRUE)
     matrixinv <- ginv(data, ...)
     # cache the inverse of the matrix
     x$setmatrixinv(matrixinv)
     # returns the inverse of the matrix
     matrixinv
}

