suppressMessages(library(fmlr))
suppressMessages(library(craze))
set.seed(1234)

n = 5
x = crossprod(matrix(runif(n*n), n))
x_fml = as_fmlmat(as_cpumat(x))

test = as.matrix(solve(x_fml))
truth = solve(x)
stopifnot(all.equal(test, truth))
