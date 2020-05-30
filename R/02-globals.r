fml_env = new.env()



get_card = function() fml_env$card
gpu_initialized = function() fml_env$gpu
init_gpu = function()
{
  if (!fmlr::fml_gpu())
    stop("GPU backend not enabled in fmlr")
  
  if (!gpu_initialized())
  {
    fml_env$gpu = TRUE
    fml_env$card = fmlr::card()
  }
  
  invisible(TRUE)
}



get_grid = function() fml_env$grid
mpi_initialized = function() fml_env$mpi
init_mpi = function()
{
  if (!fmlr::fml_mpi())
    stop("MPI backend not enabled in fmlr")
  
  if (!mpi_initialized())
  {
    fml_env$mpi = TRUE
    fml_env$grid = fmlr::grid()
  }
  
  invisible(TRUE)
}
