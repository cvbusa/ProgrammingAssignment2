makeVector <- function(x = numeric())
{
     m <- NULL
     set <- function(y)
     {
          x <<- y
          m <<- NULL
     }
     get <- function() x
     setmean <- function(mean) m <<- mean
     getmean <- function() m
     list(set = set, get = get, setmean = setmean, getmean = getmean)
}

cachemean <- function(x, ...)
{
     m <- x$getmean()
     if(!is.null(m))
     {
          message("getting cached data")
          return(m)
     }
     data <- x$get()
     m <- mean(data, ...)
     x$setmean(m)
     m
}

## set x vector to 1:10
x <-1:10
## create a list of functions (special vector) from x
xx <-makeVector(x)
## run cachemean using xx to calculate and chache the mean of x
cachemean(xx)
## run cachemean using xx again to retreive the cached mean of x, skipping the re-calculation
cachemean(xx)
## run $set() function to reset x and clear the cached mean
xx$set(x)
## run cachemean using xx and this time the mean is calculated
cachemean(xx)
