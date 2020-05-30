suppressMessages(library(craze))

x = matrix(as.double(1:6), 3)
x_fml = as_fmlmat(as_cpumat(x))

test = as.matrix(svd(x_fml, 0, 0)$d)
truth = svd(x, 0, 0)$d
stopifnot(all.equal(test, truth))
