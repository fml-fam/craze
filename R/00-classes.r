setOldClass("cpumat")
setOldClass("cpuvec")
setOldClass("gpumat")
setOldClass("gpuvec")
setOldClass("mpimat")
setClassUnion("fmlmat_s3", c("cpumat", "cpuvec", "gpumat", "gpuvec", "mpimat"))

#' Class fmlmat
#' 
#' An S4 container for fmlr vector/matrix objects.
#' 
#' @slot Data
#' An fmlr object.
#' 
#' @name fmlmat-class
#' @rdname fmlmat-class
#' 
#' @export
setClass("fmlmat", 
  representation(
    Data="fmlmat_s3"
  )
)
