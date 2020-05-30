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
NULL



#' @rdname solve
#' @export
setMethod("solve", signature(a="fmlmat"),
  function(a)
  {
    ret = DATA(a)$dupe()
    linalg_invert(ret)
    
    wrapfml(ret)
  }
)



#' @rdname solve
#' @export
setMethod("solve", signature(a="fmlmat", b="fmlmat"),
  function(a, b, ...)
  {
    a_cp = DATA(a)$dupe()
    ret = DATA(b)$dupe()
    linalg_solve(a_cp, ret)
    
    wrapfml(ret)
  }
)
