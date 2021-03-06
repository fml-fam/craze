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
#' @return
#' An \code{fmlmat} class object.
#' 
#' @examples
#' suppressMessages(library(craze))
#' 
#' x = matrix(as.double(1:6), 3)
#' x_cpumat = fmlr::as_cpumat(x, copy=FALSE)
#' 
#' x_fml = craze::as_fmlmat(x_cpumat)
#' x_fml
#' 
#' @export
as_fmlmat = function(x)
{
  if (!is_mat(x) && !is_vec(x))
    stop("'x' must be an fml matrix object")
  
  wrapfml(x)
}
