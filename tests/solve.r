suppressMessages(library(fmlr))
suppressMessages(library(craze))
set.seed(1234)

n = 5
x = crossprod(matrix(runif(n*n), n))
y = matrix(1.0:5.0, n, 1)
x_fml = as_fmlmat(as_cpumat(x))
y_fml = as_fmlmat(as_cpumat(y))

test = as.matrix(solve(x_fml, y_fml))
truth = solve(x, y)
stopifnot(all.equal(test, truth))
