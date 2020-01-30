#' as_fmlmat
#' 
#' Convert an 'fmlmat' object to an R object.
#' 
#' @details
#' The conversion does not produce a copy of the data. It is merely a shallow
#' S4 wrapper around the fmlr object.
#' 
#' @param x
#' An object of class 'fmlmat'.
#' 
#' @export
as.matrix.fmlmat = function(x)
{
  x = DATA(x)
  
  if (inherits(x, "cpumat"))
    x$to_robj()
  else if (inherits(x, "gpumat"))
  {
    ret = cpumat()
    gpu2cpu(x, ret)
    ret$to_robj()
  }
  else if (inherits(x, "mpimat"))
  {
    ret = cpumat()
    mpi2cpu(x, ret)
    ret$to_robj()
  }
}
