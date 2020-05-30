#' chol
#' 
#' Cholesky factorization.
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
  wrapfml(linalg_xpose(ret))
}
