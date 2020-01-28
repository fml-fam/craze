setOldClass("cpumat")
setOldClass("gpumat")
setOldClass("mpimat")
setClassUnion("fmlmat", c("cpumat", "gpumat", "mpimat"))

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
