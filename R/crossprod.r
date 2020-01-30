#' crossprod
#' 
#' Croddproducts.
#' 
#' @param x
#' An fmlmat matrix.
#' @param y
#' Either \code{NULL}, or an fmlmat matrix.
#' 
#' @return
#' A matrix of the same type as the inputs.
#' 
#' @name crossprod
#' @rdname crossprod
NULL



#' @rdname crossprod
#' @export
setMethod("crossprod", signature(x="fmlmat", y="ANY"),
  function(x, y=NULL)
  {
    if (is.null(y))
      ret = linalg_crossprod(x=DATA(x))
    else
      ret = linalg_matmult(transx=TRUE, transy=FALSE, x=DATA(x), y=DATA(y))
    
    wrapfml(ret)
  }
)

#' @rdname crossprod
#' @export
setMethod("tcrossprod", signature(x="fmlmat", y="ANY"),
  function(x, y=NULL)
  {
    if (is.null(y))
      ret = linalg_tcrossprod(x=DATA(x))
    else
      ret = linalg_matmult(transx=FALSE, transy=TRUE, x=DATA(x), y=DATA(y))
    
    wrapfml(ret)
  }
)
