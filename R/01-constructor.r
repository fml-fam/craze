#' as_fmlmat
#' 
#' Convert an fmlr matrix object (i.e. one of class 'cpumat', 'gpumat', or
#' 'mpimat') to an 'fmlmat' object.
#' 
#' @details
#' The conversion does not produce a copy of the data. It is merely a shallow
#' S4 wrapper around the fmlr object.
#' 
#' @param x
#' An object of class 'cpumat', 'gpumat', or 'mpimat'.
#' 
#' @examples
#' library(fmlr)
#' library(craze)
#' 
#' x = matrix(1:9, 3)
#' x_cpumat = fmlr::as_cpumat(x, copy=FALSE)
#' 
#' x_fml = craze::as_fmlmat(x_cpumat)
#' x_fml
#' 
#' @export
as_fmlmat = function(x)
{
  if (!inherits(x, "cpumat") && !inherits(x, "gpumat") && !inherits(x, "mpimat"))
    stop("'x' must be an fml matrix object")
  
  wrapfml(x)
}



ytox = function(x, y)
{
  if (inherits(x, "cpumat"))
    as_cpumat(y, copy=FALSE)
  else if (inherits(x, "gpumat"))
    as_gpumat(y)
  else if (inherits(x, "mpimat"))
    as_mpimat(y)
  else
    stop("'x' must be an fmlr cpu/gpu/mpi-matrix")
}
