## Put comments here that give an overall description of what your functions do

## Write a short comment describing this function
# This function creates a list of matrix functions
# $set(y)         : using the <<- operator, this function
#                   sets the cached matrix and clears the
#                   cached inverse of the matrix
# $get()          : gets the matrix data
# $setmatrixinv() : using the <<- operator, this function
#                   sets (calculates) and caches the inverse of the matrix
# $getmatrixinv() : gets the cached inverse of the matrix
makeCacheMatrix <- function(x = matrix()) 
{
     matrixinv <- NULL
     set <- function(y)
     {
          x <<- y
          matrixinv <<- NULL
     }
     get <- function() x
     setmatrixinv <- function(ginv) matrixinv <<- ginv
     getmatrixinv <- function() matrixinv
     list(set = set, get = get, setmatrixinv = setmatrixinv, getmatrixinv = getmatrixinv)
}

## Write a short comment describing this function
# "ginv" from the MASS package is used instead of solve
# because ginv creates a matrix pseudoinverse that works
# for all matrices
# 
# This function uses the list of matrix functions from makeCacheMatrix to
# to check for and return the cached inverse or 
# to calculate and return the calculate inverse 
# when the cached inverse is not available
cacheSolve <- function(x, ...)
{
     ## Return a matrix that is the inverse of 'x'
     matrixinv <- x$getmatrixinv()
     if(!is.null(matrixinv))
     {
          message("getting cached data")
          return(matrixinv)
     }
     data <- x$get()
     matrixinv <- ginv(data, ...)
     x$setmatrixinv(matrixinv)
     matrixinv
}


library("MASS")

x <-c(1:16)
x <-matrix(x, nrow = 4, ncol = 4, byrow = FALSE)
x
## create a list of functions (special matrix) from x
xx <-makeCacheMatrix(x)
## run cacheSolve using xx to get the chache the inverse of x or calculate the invers of x
cacheSolve(xx)
## run cacheSolve using xx again to retreive the cached inverse of x, skipping the re-calculation
cacheSolve(xx)
## run $set() function to reset x and clear the cached inverser of x
xx$set(x)
## run cacheSolve using xx and this time the inverse of x is calculated
cacheSolve(xx)

x <-c(2,0,0,1)
x <-matrix(x, nrow = 2, ncol = 2, byrow = TRUE)
x
## create a list of functions (special matrix) from x
xx <-makeCacheMatrix(x)
## run cacheSolve using xx to calculate and chache the inverse of x
cacheSolve(xx)
## run cacheSolve using xx again to retreive the cached inverse of x, skipping the re-calculation
cacheSolve(xx)
## run $set() function to reset x and clear the cached mean
xx$set(x)
## run cacheSolve using xx and this time the inverse of x is calculated
cacheSolve(xx)
