suppressMessages(library(craze))

x = matrix(as.double(1:6), 3)
x_fml = fmlmat(x)

test = as.matrix(svd(x_fml, 0, 0)$d)
truth = svd(x, 0, 0)$d
stopifnot(all.equal(test, truth))

test = as.matrix(svd(x_fml)$u)
truth = svd(x)$u
stopifnot(all.equal(abs(test), abs(truth)))
