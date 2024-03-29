<!-- README.md is generated from README.Rmd. Please edit that file -->

# CensusProtection

## How to use the open-source versions of the recommended census protection methods

This repository explains how to use tools and methods recommended for
census 2021 protection. Part 1 is related to targeted record swapping
while part 2 focuses on the cell-key method. The methods can be used
independently: it is either possible to compute unperturbed hypercubes
with swapped microdata (part 2 can be ignored), perturbed hypercubes
with original microdata (part 1 can be skipped), or perturbed hypercubes
with swapped microdata (part 1 then part 2).

The instructions below contain references to the respective
Github-repositories with the updated versions of the tools recommended
for the protection of census. The activities related with development of
tools and methods for the census protection were co-funded by Eurostat.

### Part 1: Targeted record swapping

To apply record swapping to original microdata it is possible to use
either the `R` package
[`sdcMicro`](https://github.com/sdcTools/sdcMicro)
(paragraph 1.1) or [`MuARGUS`](https://github.com/sdcTools/muargus)
(paragraph 1.2).

Both implementation use the same underlying new C++ code which is
optimized to be incredibly fast. This new implementation of the targeted
record swapping method is intended to be very close to the SAS codes
tested in the previous SGA based on the ONS codes. More information
regarding the small differences can be found in the vignettes `vignette("recordSwapping")` from
[`sdcMicro`](https://github.com/sdcTools/sdcMicro) package.

#### 1.1 R-package for targeted record swapping

Targeted record swapping is part of the package [`github.com/sdcTools/sdcMicro`](https://github.com/sdcTools/sdcMicro), function `recordSwap()`. The vignette for targeted record swapping is callable via `vignette("recordSwapping")`.

#### 1.2 MuARGUS

The latest release of [`MuARGUS`](https://github.com/sdcTools/muargus)
that includes the implementation of record swapping is available at
[`github.com/sdcTools/muargus/releases`](https://github.com/sdcTools/muargus/releases)
where also a quick reference documentation with explanations and
screenshots can be downloaded.

### Part 2: Cell-key method

The cell-key method can be applied either with the R package
[`cellKey`](https://github.com/sdcTools/cellKey) (paragraph 2.2) or
[`tauArgus`](https://github.com/sdcTools/tauargus) (paragraph 2.3). Both
implementation use the [`ptable`](https://github.com/sdcTools/ptable)
package (paragraph 2.1).

#### 2.1 R-package ptable

The package is developed at
[`github.com/sdcTools/ptable`](https://github.com/sdcTools/ptable) where
also installation instructions and example usage can be found. The
package includes a vignette and a graphical user interface and it can
draw plots that describe the perturbations that will be applied to the
hypercubes based on a specific pTable with the
[`cellKey`](https://github.com/sdcTools/cellKey) package,
[`tauArgus`](https://github.com/sdcTools/tauargus) or SAS macros.

#### 2.2 R-package cellKey

The package is developed at
[`github.com/sdcTools/cellKey`](https://github.com/sdcTools/cellKey)
where also installation instructions and example usage can be found. The
package includes also a detailed vignette that helps users getting
started with the functionality of the package.

##### Instructions for installing R-packages

```
install.packages(c("data.table","devtools","R.utils","sdcTable","sdcMicro","sdcHierarchies","remotes"))

# install ptable
devtools::install_github("sdcTools/ptable", dependencies=c("Depends","Imports"), force=TRUE, build_opts="--build-vignettes")
# install cellKey
remotes::install_github(repo = "sdcTools/cellKey", dependencies = TRUE, build_opts = "--no-resave-data", force = TRUE)
```


#### 2.3 TauARGUS

The latest release of [`TauArgus`](https://github.com/sdcTools/tauargus)
that includes the implementation of the cellKey method is available at
[`github.com/sdcTools/tauargus/releases`](https://github.com/sdcTools/tauargus/releases)
where also a quick reference documentation with explanations and
screenshots can be downloaded.
