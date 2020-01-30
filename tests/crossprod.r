suppressMessages(library(fmlr))
suppressMessages(library(craze))

x = matrix(as.double(1:30), 10)
y = matrix(as.double(1:10), 10, 2)
z = matrix(as.double(1:5), 5, 3)

x_fml = as_fmlmat(as_cpumat(x))
y_fml = as_fmlmat(as_cpumat(y))
z_fml = as_fmlmat(as_cpumat(z))



test = as.matrix(crossprod(x_fml))
truth = crossprod(x)
stopifnot(all.equal(test[lower.tri(test, TRUE)], truth[lower.tri(truth, TRUE)]))

test = as.matrix(crossprod(x_fml, y_fml))
truth = crossprod(x, y)
stopifnot(all.equal(test[lower.tri(test, TRUE)], truth[lower.tri(truth, TRUE)]))



test = as.matrix(tcrossprod(x_fml))
truth = tcrossprod(x)
stopifnot(all.equal(test[lower.tri(test, TRUE)], truth[lower.tri(truth, TRUE)]))

test = as.matrix(tcrossprod(x_fml, z_fml))
truth = tcrossprod(x, z)
stopifnot(all.equal(test[lower.tri(test, TRUE)], truth[lower.tri(truth, TRUE)]))
