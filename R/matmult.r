#' matmult
#' 
#' Matrix multiplication.
#' 
#' @param x,y
#' fmlmat matrices.
#' 
#' @return
#' A matrix of the same type as the inputs.
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
