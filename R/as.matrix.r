#' as.matrix
#' 
#' Convert an 'fmlmat' object to an R object.
#' 
#' @details
#' The conversion does not produce a copy of the data. It is merely a shallow
#' S4 wrapper around the fmlr object.
#' @param ...
#' Ignored.
#' 
#' @param x
#' An object of class 'fmlmat'.
#' 
#' @export
as.matrix.fmlmat = function(x, ...)
{
  x = DATA(x)
  
  if (is_cpumat(x) || is_cpuvec(x))
    x$to_robj()
  else if (is_gpumat(x) || is_gpuvec(x))
  {
    if (is_gpumat(x))
      ret = cpumat()
    else
      ret = cpuvec()
    
    gpu2cpu(x, ret)
    ret$to_robj()
  }
  else if (is_mpimat(x))
  {
    ret = cpumat()
    mpi2cpu(x, ret)
    ret$to_robj()
  }
}
