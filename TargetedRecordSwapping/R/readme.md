# Installing R-Package `recordSwapping`

## Directly from R

```
install.packages("devtools")
library(devtools)
devtools::install_github("sdcTools/recordSwapping",ref="recordSwapping_prototype",
                         build_vignette=TRUE,dependencies=TRUE) 
```

## Dowloading .tar.gz and install locally

+ Download .tar.gz-File under https://github.com/sdcTools/recordSwapping/archive/recordSwapping_prototype.tar.gz.
+ Open a terminal window and go to the directory that contains the .tar.gz-File (with `cd`).
+ When you are at the desired directory type

```
R CMD INSTALL recordSwapping-recordSwapping_prototype.tar.gz
```

Afterwards start R and type `library(recordSwapping)` to load the package into the R-Session.

## Package vignette

The package `recordSwapping` contains a vignette which can be called through:

```
library(recordSwapping)
vignette("recordSwapping")
```

The vignette contains all the informations needed to get started with the package.