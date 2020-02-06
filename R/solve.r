#' solve
#' 
#' Solve a system of equations or invert a matrix.
#' 
#' @param a,b
#' fmlmat matrices.
#' @param ...
#' Ignored.
#' 
#' @name solve
#' @rdname solve
#' @export
setMethod("solve", signature(a="fmlmat", b="ANY"),
  function(a, b, ...)
  {
    if (!missing(b))
    {
      a_cp = DATA(a)$dupe()
      ret = DATA(b)$dupe()
      linalg_solve(a_cp, ret)
    }
    else
    {
      ret = DATA(a)$dupe()
      linalg_invert(ret)
    }
    
    wrapfml(ret)
  }
)
