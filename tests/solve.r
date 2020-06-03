suppressMessages(library(stats))
suppressMessages(library(craze))


if (fml_mpi()){
  comm.set.seed(1234)
} else {
  set.seed(1234)
}


n = 5
x = crossprod(matrix(runif(n*n), n))
y = matrix(1.0:5.0, n, 1)
x_fml = fmlmat(x)
y_fml = fmlmat(y)

test = as.matrix(solve(x_fml, y_fml))
truth = solve(x, y)
stopifnot(all.equal(test, truth))

### R's, but not fmlr/craze's solve() is having issues, possibly with openblas?
# test = as.matrix(solve(x_fml))
# truth = solve(x)
# stopifnot(all.equal(test, truth))
