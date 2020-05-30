suppressMessages(library(stats))
suppressMessages(library(craze))
set.seed(1234)

n = 5
x = crossprod(matrix(runif(n*n), n))
y = matrix(1.0:5.0, n, 1)
x_fml = as_fmlmat(as_cpumat(x))

test = t(as.matrix(chol(x_fml)))
truth = chol(x)
stopifnot(all.equal(test, truth))
