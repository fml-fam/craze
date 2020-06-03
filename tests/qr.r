suppressMessages(library(craze))

x = matrix(as.double(1:6), 3)
x_fml = fmlmat(x)

qr = qr(x)
qr_fml = qr(x_fml)

truth = qr.Q(qr)
test = as.matrix(qr.Q(qr_fml))
stopifnot(all.equal(test, truth))

truth = qr.R(qr)
test = as.matrix(qr.R(qr_fml))
stopifnot(all.equal(test, truth))
