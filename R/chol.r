#' chol
#' 
#' Cholesky factorization.
#' 
#' @details
#' Returns the LOWER Cholesky factor. R returns the upper.
#' 
#' @param x
#' An fmlmat matrix.
#' @param ...
#' Ignored.
#' 
#' @name chol
#' @rdname chol
#' @export
chol.fmlmat = function(x, ...)
{
  ret = DATA(x)$dupe()
  linalg_chol(ret)
  wrapfml(ret)
}
