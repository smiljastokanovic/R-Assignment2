## Put comments here that give an overall description of what your
## functions do

## Creates a special matrix object that can cache its inverse

makeCacheMatrix <- function(m = matrix()) {
  
  inv <- NULL
  set <- function(matrix) {
    m<<-matrix
    inv <<- NULL
  }
  get <- function() {m}
  setinv <- function(inv) {inv <<- inverse}
  getinv <- function() {inv}
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
  
}


## Calculate inverse matrix

cacheSolve <- function(x, ...) {
  m <- x$getinv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data)%*%data
  x$setinv(m)
  m  
  
  }