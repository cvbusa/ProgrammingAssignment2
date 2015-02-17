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

## set x vector to 1 to 10 & set y vector to 5 to 10
x <-1:10
y <-5:10
## create a list of functions called LOF (initialized for vector equal to x, cached mean set to null)
LOF <-makeVector(x)
## run cachemean using LOF to calculate the mean and cache the mean (vector equal to x)
cachemean(LOF)
## run cachemean using LOF again to retreive the cached mean (vector equal to x) & skipping the mean calculation
cachemean(LOF)
## run LOF$set function to reset the vector to x and clear the cached mean
LOF$set(x)
## run cachemean using LOF and this time the mean is calculated and cached again
cachemean(LOF)
## run LOF$set function to reset the vector this time to y and clear the cached mean
LOF$set(y)
## run cachmean using LOF now to calculate the mean and cache the mean (vector equal to y)
cachemean(LOF)
## run cachmean using LOF again to retreive the cached mean (vector equal to y) & skipping the mean calculation alculate
cachemean(LOF)
