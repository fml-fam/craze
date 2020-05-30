#' QR
#' 
#' QR factorization.
#' 
#' @param x
#' An fmlmat matrix.
#' @param complete,Dvec,...
#' Ignored.
#' 
#' @name qr
#' @rdname qr
NULL



setOldClass("qr_fml")



#' @rdname qr
#' @export
qr.fmlmat = function(x, ...)
{
  x_cp = DATA(x)$dupe()
  qraux = skeleton_vec(x_cp)
  
  linalg_qr(x_cp, qraux)
  
  ret = list(
    qr = wrapfml(x_cp),
    rank = NA,
    qraux = wrapfml(qraux),
    pivot = NA
  )
  
  class(ret) = "qr_fml"
  ret
}



#' @rdname qr
#' @export
setGeneric(name="qr.Q", useAsDefault=base::qr.Q, package="craze")

#' @rdname qr
#' @export
setMethod("qr.Q", signature(qr="qr_fml"),
  function(qr, complete=FALSE, Dvec)
  {
    Q = skeleton_mat(qr$qr)
    work = skeleton_vec(qr$qr)
    
    linalg_qr_Q(DATA(qr$qr), DATA(qr$qraux), Q, work)
    
    wrapfml(Q)
  }
)



#' @rdname qr
#' @export
setGeneric(name="qr.R", useAsDefault=base::qr.R, package="craze")

#' @rdname qr
#' @export
setMethod("qr.R", signature(qr="qr_fml"),
  function(qr, complete=FALSE)
  {
    R = skeleton_mat(qr$qr)
    
    linalg_qr_R(DATA(qr$qr), R)
    
    wrapfml(R)
  }
)
