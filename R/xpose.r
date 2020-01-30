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
setMethod("t", signature(x="float32"),
  function(x)
  {
    linalg_xpose(x)
  }
)
