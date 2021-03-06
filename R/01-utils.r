is_cpumat = function(x) inherits(x, "cpumat")
is_cpuvec = function(x) inherits(x, "cpuvec")
is_gpuvec = function(x) inherits(x, "gpuvec")
is_gpumat = function(x) inherits(x, "gpumat")
is_mpimat = function(x) inherits(x, "mpimat")
is_fmlmat = function(x) inherits(x, "fmlmat")

is_mat = function(x) is_cpumat(x) || is_gpumat(x) || is_mpimat(x)
is_vec = function(x) is_cpuvec(x) || is_gpuvec(x)



skeleton_mat = function(x)
{
  if (is_fmlmat(x))
    skeleton_mat(DATA(x))
  
  else if (is_cpumat(x) || is_cpuvec(x))
    cpumat(type=x$get_type_str())
  
  else if (is_gpumat(x) || is_gpuvec(x))
    gpumat(x$get_card(), type=x$get_type_str())
  
  else if (is_mpimat(x))
    mpimat(x$get_grid(), type=x$get_type_str())
}

skeleton_vec = function(x)
{
  if (is_fmlmat(x))
    skeleton_vec(DATA(x))
  
  else if (is_cpumat(x) || is_cpuvec(x))
    cpuvec(type=x$get_type_str())
  
  else if (is_gpumat(x) || is_gpuvec(x))
    gpuvec(x$get_card(), type=x$get_type_str())
  
  else if (is_mpimat(x))
    mpimat(x$get_grid(), type=x$get_type_str())
}



DATA = function(x) x@Data
wrapfml = function(x) new("fmlmat", Data=x)



ytox = function(x, y)
{
  if (is_cpumat(x))
    as_cpumat(y, copy=FALSE)
  else if (is_gpumat(x))
    as_gpumat(x$get_card(), y)
  else if (is_mpimat(x))
    as_mpimat(x$get_grid(), y)
  else
    stop("'x' must be an fmlr cpu/gpu/mpi-matrix")
}
