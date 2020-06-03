suppressMessages(library(craze))

x = matrix(as.double(1:30), 10)
y = matrix(as.double(1:9), 3)

x_fml = fmlmat(x)
y_fml = fmlmat(y)



test = as.matrix(x_fml %*% y_fml)
truth = x %*% y
stopifnot(all.equal(test, truth))
