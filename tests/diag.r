suppressMessages(library(craze))

x = matrix(as.double(1:6), 3)
v = c(3.0, 7.0)
x_fml = as_fmlmat(as_cpumat(x))
v_fml = as_fmlmat(as_cpuvec(v))

test = as.matrix(diag(x_fml))
truth = diag(x)
stopifnot(all.equal(test, truth))

test = as.matrix(diag(v_fml, 5, 4))
truth = diag(v, 5, 4)
stopifnot(all.equal(test, truth))
