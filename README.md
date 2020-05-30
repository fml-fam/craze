# craze

* **Version:** 0.2-1
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/fml-fam/fmlr
* **Bug reports**: https://github.com/fml-fam/fmlr/issues


High-level, R-like interface for [fmlr](https://github.com/fml-fam/fmlr). The package name is a play on the German word 'fimmel' (fml, fimmel, ...).

The goal of the package is to give a more traditional, R-like interface around fmlr functions and methods. It's basically just a shallow S4 wrapper. The canonical use case would be something like:

* build your matrix in R
* convert to an fmlr object:
    - the easy way: use `fmlmat()`
    - the harder, more robust way:
        - convert the R matrix to an fmlr object via `as_cpumat()`, `as_gpumat()`, or `as_mpimat()` (may require a copy)
        - convert to a craze `fmlmat` object via `as_fmlmat()` (no copy)
* call the desired linear algebra function(s)



## Installation

You will need an installation of [fmlr](https://github.com/fml-fam/fmlr). See the [fmlr installation guide](https://fml-fam.github.io/fmlr/html/articles/01-installation.html) for more details.

You can install the stable version from [the HPCRAN](https://hpcran.org) using the usual `install.packages()`:

```r
install.packages("craze", repos=c("https://hpcran.org", "https://cran.rstudio.com"))
```

The development version of craze is maintained on GitHub:

```r
remotes::install_github("fml-fam/craze")
```



## Example

Multiplying CPU data:

```r
library(craze)

x = matrix(as.double(1:9), 3)
x_cpu = fmlmat(x)
x_cpu
```

    ## # cpumat 3x3 type=d
    ## 1.0000 4.0000 7.0000 
    ## 2.0000 5.0000 8.0000 
    ## 3.0000 6.0000 9.0000 

```r
x_cpu %*% x_cpu
```

    ## # cpumat 3x3 type=d
    ## 30.0000 66.0000 102.0000 
    ## 36.0000 81.0000 126.0000 
    ## 42.0000 96.0000 150.0000 

and GPU data:

```r
x_gpu = fmlmat(x, backend="gpu")
x_gpu
```

    ## # gpumat 3x3 type=d 
    ## 1.0000 4.0000 7.0000 
    ## 2.0000 5.0000 8.0000 
    ## 3.0000 6.0000 9.0000 

```r
x_gpu %*% x_gpu
```

    ## # gpumat 3x3 type=d 
    ## 30.0000 66.0000 102.0000 
    ## 36.0000 81.0000 126.0000 
    ## 42.0000 96.0000 150.0000 



## Benchmark

Throughout, I'm using:

* R
    - R version 3.6.2
    - float version 0.2-4
    - fml version 0.2-1
    - craze version 0.1-0
* CPU
    - AMD Ryzen 7 1700X Eight-Core Processor
    - OpenBLAS with 8 threads
* GPU
    - NVIDIA GeForce GTX 1070 Ti
    - cuBLAS

Let's take a look at a quick matrix multiplication benchmark. First, we need to set up the test matrices:

```r
library(craze)

n = 5000
x = matrix(runif(n*n), n, n)
x_flt = fl(x)
x_cpu = fmlmat(x)
x_gpu = fmlmat(x, type="float", backend="gpu")
```

We're using float for the GPU data because my graphics card doesn't have the full double precision cores. That change should give us a roughly 2x run-time advantage over a double precision test, like the R version. It's more amenable to the float test.

First we'll time the R matrix product (double precision, CPU)

```r
system.time(x %*% x)
```

    ##   user  system elapsed 
    ## 10.241   0.330   1.345

As I recall, R's matrix multiplication does some pre-scanning for bad numerical values. None of the implementations that follow do, so there is some overhead in this implementation that may or may not be of value to you.

Here's the float test (single precision, CPU)

```r
system.time(x_flt %*% x_flt)
```

    ##  user  system elapsed 
    ## 4.898   0.212   0.640 

This is a little more than twice as fast, which makes sense.

Here's a double precision test using fmlr as the backend (double precision, CPU)

```r
system.time(x_cpu %*% x_cpu)
```

    ##   user  system elapsed 
    ## 10.285   0.317   1.327 

Even with the overhead of the R version, the run times are essentially the same. This is expected, since most of the work is actually in computing the product. And both are calling out to the same `dgemm()` function in OpenBLAS. The float version above is calling `sgemm()` from OpenBLAS.

The GPU numbers are pretty different though:

```r
system.time(x_gpu %*% x_gpu)
```

    ##  user  system elapsed 
    ## 0.002   0.001   0.002

This is more than 300x faster than the CPU float version. There's a reason I chose matrix multiplication for this benchmark 😉


| Benchmark | Precision | Wall-clock time | Relative Performance |
|-----------|-----------|----------------:|---------------------:|
| R matrix `x` | double | 1.345 | 672.5 |
| float matrix `x_flt` | single | 0.640 | 320.0 |
| fmlr CPU matrix `x_cpu` | double | 1.327 | 663.5 |
| fmlr GPU matrix `x_gpu` | single | 0.002 | 1.0 |
