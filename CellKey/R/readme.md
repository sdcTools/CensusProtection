## Installation of the cell-Key package prototype

This document will help you to install and apply the [**cellKey**](https://github.com/sdcTools/cellKey) package which allows to create perturbed statistical tables.

### Installation of required packages
Both the [**cellKey**](https://github.com/sdcTools/cellKey) and the [**ptable**](https://github.com/sdcTools/ptable) package are not yet on CRAN and therefore must be installed using the  [**devtools**](https://cran.r-project.org/package=devtools) package.

#### devtools
This package allows to install packages directly from github and can be installed directly from CRAN. To do so, the following command in **R** installs the package along with all its dependencies and finally loads it:

```
if (!require("devtools")) install.packages("devtools")
library(devtools)
```

#### ptable
The [**ptable**](https://github.com/sdcTools/ptable) package is a requirement for the [**cellKey**](https://github.com/sdcTools/cellKey) package. It can be installed directly from github using function `install_github()`:

```
install_github("sdcTools/ptable", ref="master", build_vignette=TRUE, dependencies=TRUE)
```

If you experience a timeout due to a proxy server while downloading, one can work around this issue by specifying the proxy-server using the httr package:

```
if (!require("httr")) install.packages("httr")
httr::set_config(use_proxy(url="xxx.xxx.xxx.xxx", port=yy))
```

#### cellKey
To install the [**cellKey**](https://github.com/sdcTools/cellKey) for the prototype testing, there are two possibilities.

One is to download the compressed file [**v0.15.0.tar.gz**](https://github.com/sdcTools/cellKey/archive/v0.15.0.tar.gz) and issue the following command:

```
install_local("/path/to/downloaded/cellKey_0.15.0.tar.gz",
  build_vignette=TRUE, dependencies=TRUE)
```

The second method allows to install the package directly from github without the need to explicitly download a file. This can be done as follows:

```
install_github("sdcTools/cellKey", ref="v0.15.0", build_vignette=TRUE, dependencies=TRUE)
```

### Using the package
Once the package has been installed, it can be loaded and its functionality can be used. [**cellKey**](https://github.com/sdcTools/cellKey) contains a so-called *"vignette"* which is a demonstration of the features. The vignette can be read in the browser by issuing the following command:

```
library(cellKey)
ck_vignette()
```

Furthermore, all functions are documented and the help-index of the package can be started using

```
help(pa=cellKey)
```

### Further Information
The package is developed in its seperate github-repository at [**sdcTools/cellKey**](https://github.com/sdcTools/cellKey) where additional information such as changes between versions are documented.

### Feedback
Feedback (via issues) in the [**issue-tracker**](https://github.com/sdcTools/cellKey/issues) with regards to bugs or features requests are welcome as well as pull-requests. One the package is deemed stable, a version will be released on CRAN too.
