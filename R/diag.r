#' diag
#' 
#' Create a diagonal matrix from a vector, or alternatively, get the vector of
#' diagonal entries from a matrix.
#' 
#' @param x
#' fmlmat vector or matrix.
#' @param nrow,ncol
#' The dimension of the resulting matrix if specified.
#' @param names
#' Ignored.
#' 
#' @aliases diag,fmlmat-method
#' 
#' @name diag
#' @rdname diag
#' @export
setMethod("diag", signature(x="fmlmat"),
  function(x, nrow, ncol, names=TRUE) 
  {
    # get vector from matrix
    if (missing(nrow) && missing(ncol))
    {
      if (!is_mat(DATA(x)))
        stop("'x' is an array, but not one-dimensional.")
      
      ret = skeleton_vec(x)
      DATA(x)$diag(ret)
    }
    # create matrix
    else
    {
      if (!is_vec(DATA(x)))
        stop("'nrow' or 'ncol' cannot be specified when 'x' is a matrix")
      
      if (missing(ncol))
        ncol = nrow
      if (missing(nrow))
        nrow = ncol
      
      ret = skeleton_mat(x)
      ret$resize(nrow, ncol)
      ret$fill_diag(DATA(x))
    }
    
    wrapfml(ret)
  }
)
