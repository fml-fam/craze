#' eigen
#' 
#' Eigenvalue decomposition.
#' 
#' @details
#' Symmetric matrices only.
#' 
#' @param x
#' An fmlmat matrix.
#' @param only.values
#' Should only the eigenvalues be returned?
#' @param symmetric,EISPACK
#' Ignored.
#' 
#' @name eigen
#' @rdname eigen
NULL



eigen_fml = function(x, symmetric, only.values=FALSE, EISPACK=FALSE)
{
  x_cp = DATA(x)$dupe()
  val = skeleton_vec(x_cp)
  
  if (isTRUE(only.values))
    fmlr::linalg_eigen_sym(x_cp, val)
  else
  {
    vec = skeleton_mat(x_cp)
    fmlr::linalg_eigen_sym(x_cp, val, vec)
  }
  
  ret = list()
  ret$values = wrapfml(val)
  if (!isTRUE(only.values))
    ret$vectors = wrapfml(vec)
  
  ret
}



#' @rdname eigen
#' @export
setMethod("eigen", signature(x="fmlmat"), eigen_fml)
