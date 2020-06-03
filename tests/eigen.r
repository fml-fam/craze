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

e_test = eigen(x_fml)
e_truth = eigen(x)

test = as.matrix(e_test$values)
truth = e_truth$values
stopifnot(all.equal(test, truth))

test = as.matrix(e_test$vectors)
truth = e_truth$vectors
stopifnot(all.equal(abs(test), abs(truth)))
