#' transpose
#' 
#' Transpose.
#' 
#' @param x
#' An fmlmat matrix.
#' 
#' @return
#' A matrix of the same type as the inputs.
#' 
#' @name transpose
#' @rdname transpose
NULL



#' @rdname transpose
#' @export
setGeneric(name = "t", useAsDefault=base::t, package="craze")



#' @rdname transpose
#' @export
setMethod("t", signature(x="fmlmat"),
  function(x)
  {
    ret = linalg_xpose(DATA(x))
    wrapfml(ret)
  }
)
