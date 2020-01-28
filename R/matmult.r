#' matmult
#' 
#' Matrix multiplication for numeric/float matrices.
#' 
#' @details
#' If a numeric matrix is multiplied against a float matrix, then if the
#' "numeric" matrix is integers, the integers are promoted to floats. Otherwise,
#' the float matrix is promoted to doubles.
#' 
#' @param x,y
#' Numeric/float matrices.
#' 
#' @return
#' A matrix of the same type as the highest precision input.
#' 
#' @examples
#' library(float)
#' 
#' s1 = flrunif(5, 5)
#' s2 = flrunif(5, 2)
#' x = matrix(1:25, 5)
#' 
#' s1 %*% s2 # float
#' 
#' storage.mode(x) # integer
#' x %*% s2 # float
#' 
#' storage.mode(x) = "double"
#' x %*% s2 # double
#' 
#' @name matmult
#' @rdname matmult
NULL



#' @rdname matmult
#' @export
setMethod("%*%", signature(x="fmlmat", y="fmlmat"),
  function(x, y)
  {
    ret = linalg_matmult(x=DATA(x), y=DATA(y))
    wrapfml(ret)
  }
)

#' @rdname matmult
#' @export
setMethod("%*%", signature(x="fmlmat", y="matrix"),
  function(x, y)
  {
    y_fml = ytox(x, y)
    ret = linalg_matmult(x=DATA(x), y=DATA(y))
    wrapfml(ret)
  }
)

#' @rdname matmult
#' @export
setMethod("%*%", signature(x="matrix", y="fmlmat"),
  function(x, y)
  {
    x_fml = ytox(y, x)
    ret = linalg_matmult(x=DATA(x), y=DATA(y))
    wrapfml(ret)
  }
)
