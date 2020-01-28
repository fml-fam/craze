# craze

* **Version:** 0.1-0
* **Status:** [![Build Status](https://travis-ci.org/wrathematics/craze.png)](https://travis-ci.org/wrathematics/craze)
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/wrathematics/fmlr
* **Bug reports**: https://github.com/wrathematics/fmlr/issues
* **Documentation**: TODO


High-level, R-like interface for fmlr. The package name is a play on the German word 'fimmel'.

The goal of the package is to give a move traditional R-like interface around fmlr functions and methods. It's basically just a shallow S4 wrapper. The canonical use case would be something like:

* build your matrix in R
* convert to an fmlr object via `as_cpumat()`, `as_gpumat()`, or `as_mpimat()` depending on what you want (may require a copy)
* convert to the craze `fmlmat` S4 object via `as_fmlmat()` (no copy)
* call the desired linear algebra function(s)


## Installation

The development version is maintained on GitHub:

```r
remotes::install_github("wrathematics/craze")
```



## Example

```r
library(fmlr)
library(craze)

x = matrix(1:9, 3)
x_cpumat = fmlr::as_cpumat(x, copy=FALSE)

x_fml = craze::as_fmlmat(x_cpumat)
x_fml
## # cpumat 3x3 type=d
## 1.0000 4.0000 7.0000 
## 2.0000 5.0000 8.0000 
## 3.0000 6.0000 9.0000 

x_fml %*% x_fml
## # cpumat 3x3 type=d
## 30.0000 66.0000 102.0000 
## 36.0000 81.0000 126.0000 
## 42.0000 96.0000 150.0000 



c = card()
x_gpumat = as_gpumat(c, x)
x_fml = craze::as_fmlmat(x_gpumat)
x_fml
## # gpumat 3x3 type=d 
## 1.0000 4.0000 7.0000 
## 2.0000 5.0000 8.0000 
## 3.0000 6.0000 9.0000 

x_fml %*% x_fml
## # gpumat 3x3 type=d 
## 30.0000 66.0000 102.0000 
## 36.0000 81.0000 126.0000 
## 42.0000 96.0000 150.0000 
```
