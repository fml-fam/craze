suppressMessages(library(fmlr))
suppressMessages(library(craze))

x = matrix(as.double(1:30), 10)
y = matrix(as.double(1:9), 3)

x_fml = as_fmlmat(as_cpumat(x))
y_fml = as_fmlmat(as_cpumat(y))



test = as.matrix(x_fml %*% y_fml)
truth = x %*% y
stopifnot(all.equal(test, truth))
