#' SVD
#' 
#' Singular value decomposition.
#' 
#' @param x
#' An fmlmat matrix.
#' @param nu,nv
#' The number of left/right singular vectors to return. NOTE: currently only
#' supports 0 or non-zero values.
#' @param LINPACK
#' Ignored.
#' 
#' @name svd
#' @rdname svd
NULL



utils::globalVariables(c("n", "p"))



La_svd_fml = function(x, nu=min(n, p), nv=min(n, p))
{
  n = DATA(x)$nrows()
  p = DATA(x)$ncols()
  
  if (n == 0 || p == 0)
    stop("a dimension is zero")
  
  nu = as.integer(nu)
  if (is.na(nu) || nu < 0)
    stop("argument must be coercible to non-negative integer")
  
  nv = as.integer(nv)
  if (is.na(nv) || nv < 0)
    stop("argument must be coercible to non-negative integer")
  
  x_cp = DATA(x)$dupe()
  d = skeleton_vec(x_cp)
  
  if (nu == 0 && nv == 0)
    linalg_svd(x_cp, d)
  else
  {
    u = skeleton_mat(x_cp)
    vt = skeleton_mat(x_cp)
    linalg_svd(x_cp, d, u, vt)
  }
  
  ret = list()
  ret$d = wrapfml(d)
  if (nu)
    ret$u = wrapfml(u)
  if (nv)
    ret$vt = wrapfml(vt)
  
  ret
}



svd_fml = function(x, nu=min(n, p), nv=min(n, p), LINPACK=FALSE) 
{
  n = DATA(x)$nrows()
  p = DATA(x)$ncols()

  ret = La_svd_fml(x, nu, nv)
  if (nv)
  {
    ret$v = wrapfml(linalg_xpose(DATA(ret$vt)))
    ret$vt = NULL
  }

  ret
}



#' @rdname svd
#' @export
setMethod("La.svd", signature(x="fmlmat"), La_svd_fml)

#' @rdname svd
#' @export
setMethod("svd", signature(x="fmlmat"), svd_fml)
