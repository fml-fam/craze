setOldClass("cpumat")
setOldClass("cpuvec")
setOldClass("gpumat")
setOldClass("gpuvec")
setOldClass("mpimat")
setClassUnion("fmlmat", c("cpumat", "cpuvec", "gpumat", "gpuvec", "mpimat"))

#' Class fmlmat
#' 
#' An S4 container for fmlr vector/matrix objects.
#' 
#' @slot Data
#' An fmlr object.
#' 
#' @name float32-class
#' @docType class
#' 
#' @export
setClass("fmlmat", 
  representation(
    Data="fmlmat"
  )
)



DATA = function(x) x@Data
wrapfml = function(x) new("fmlmat", Data=x)



ytox = function(x, y)
{
  if (inherits(x, "cpumat"))
    as_cpumat(y, copy=FALSE)
  else if (inherits(x, "gpumat"))
    as_gpumat(x$get_card(), y)
  else if (inherits(x, "mpimat"))
    as_mpimat(x$get_grid(), y)
  else
    stop("'x' must be an fmlr cpu/gpu/mpi-matrix")
}
