suppressMessages(library(craze))

x = matrix(as.double(1:30), 10)
x_fml = fmlmat(x)

test = as.matrix(t(x_fml))
truth = t(x)
stopifnot(all.equal(test, truth))
