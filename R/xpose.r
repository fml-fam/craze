#' xpose
#' 
#' Transpose.
#' 
#' @param x
#' An fmlmat matrix.
#' 
#' @return
#' A matrix of the same type as the inputs.
#' 
#' @name xpose
#' @rdname xpose
#' @export
setMethod("t", signature(x="fmlmat"),
  function(x)
  {
    ret = linalg_xpose(DATA(x))
    wrapfml(ret)
  }
)
