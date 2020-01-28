#' print-fmlmat
#' 
#' Print methods for fmlmat objects.
#' 
#' @param x,object
#' An fmlmat vector/matrix.
#' @param ...
#' Ignored.
#' 
#' @name print-fmlmat
#' @rdname print-fmlmat
NULL



print_fmlmat = function(x, ...)
{
  DATA(x)$info()
  DATA(x)$print()
  invisible()
}

#' @rdname print-fmlmat
#' @export
setMethod("print", signature(x="fmlmat"), print_fmlmat)

#' @rdname print-fmlmat
#' @export
setMethod("show", signature(object="fmlmat"), function(object) print_fmlmat(object))
