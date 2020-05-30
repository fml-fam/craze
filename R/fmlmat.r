#' fmlmat
#' 
#' Cast an R matrix as an \code{fmlmat} object, or create a skeleton
#' \code{fmlmat} object.
#' 
#' @details
#' Must pass either \code{x} (an R object to cast) or \code{nrows}/\code{ncols},
#' but not both.
#' 
#' GPU data will use the defaults from \code{fmlr::card()}, and MPI data will
#' use the defaults from \code{fmlr::grid()}. If you need more control, you
#' should use the fmlr constructors and convert with \code{craze::as_fmlmat()}.
#' 
#' @param x
#' A numeric R matrix/vector. Can be of integer or double type, or a
#' \code{float32} object of float data (from the float package).
#' @param nrows,ncols
#' The number of rows/columns for a skeleton matrix.
#' @param type
#' The fundamental type. Should be one of \code{"int"}, \code{"float"}, or
#' \code{"double"}.
#' @param backend
#' Should be one of \code{"cpu"}, \code{"gpu"}, or \code{"mpi"}.
#' 
#' @return
#' An \code{fmlmat} class object.
#' 
#' @examples
#' suppressMessages(library(craze))
#' 
#' x = matrix(as.double(1:6), 3)
#' x_cpu = fmlmat(x)
#' x_cpu
#' 
#' @export
fmlmat = function(x, nrows, ncols, type="double", backend="cpu")
{
  backend = match.arg(tolower(backend), c("cpu", "gpu", "mpi"))
  
  if (missing(nrows) && missing(ncols))
  {
    if (missing(x))
      stop("must supply a matrix or dimensional nrows/ncols")
    
    nrows = nrow(x)
    ncols = ncol(x)
  }
  else if (missing(nrows) || missing(ncols))
  {
    if (!missing(x))
      stop("can not supply both a matrix and dimensional information")
    
    if (missing(nrows))
      nrows = 1
    else
      ncols = 1
  }
  else if (!missing(x))
    stop("can not supply both a matrix and dimensional information")
  
  
  # TODO matrix/vector/numeric checks
  
  if (backend == "cpu")
  {
    if (!missing(x))
    {
      if ((type == "float" && !float::is.float(x)) || (type == "double" && !is.double(x)) || (type == "int" && !is.integer(x)))
      {
        if (is.matrix(x))
          ret = cpumat(type=type)$from_robj(x)
        else
          ret = cpuvec(type=type)$from_robj(x)
      }
      else
      {
        if (is.matrix(x))
          ret = cpumat(type=type)$inherit(x)
        else
          ret = cpuvec(type=type)$inherit(x)
      }
    }
    else
      ret = cpumat(nrows, ncols, type=type)
  }
  else if (backend == "gpu")
  {
    init_gpu()
    if (!missing(x))
    {
      if (is.matrix(x))
        ret = gpumat(get_card(), type=type)$from_robj(x)
      else
        ret = gpuvec(get_card(), type=type)$from_robj(x)
    }
    else
      ret = gpumat(get_card(), nrows, ncols, type=type)
  }
  else if (backend == "mpi")
  {
    init_mpi()
    if (!missing(x))
      ret = mpimat(get_grid(), type=type)$from_robj(x)
    else
      ret = mpimat(get_grid(), nrows, ncols, type=type)
  }
  
  
  wrapfml(ret)
}
