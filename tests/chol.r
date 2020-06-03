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

test = as.matrix(chol(x_fml))
truth = chol(x)
stopifnot(all.equal(test, truth))
