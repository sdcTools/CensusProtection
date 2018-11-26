## Installation of the ptable package prototype*

This document will help you to install and apply the [**ptable**](https://github.com/sdcTools/ptable) package which allows to generate peturbation tables that are necessary for the [**cellkey**](https://github.com/sdcTools/cellkey) package and for  [**tauargus**](https://github.com/sdcTools/tauargus).

### Installation of required packages
The [**ptable**](https://github.com/sdcTools/ptable) package is not yet on CRAN and therefore must be installed using the  [**devtools**](https://cran.r-project.org/package=devtools) package.

#### bring your R-packages up to date
The following commands updates all your R-packages which is a good idea to do if one works with (development) packages.  
  
```
install.packages(ask=FALSE)
```

#### devtools
This package allows to install packages directly from github and can be installed directly from CRAN. To do so, the following command in **R** installs the package along with all its dependencies and finally loads it:

```
if (!require("devtools")) install.packages("devtools")
library(devtools)
```

#### ptable
To install the [**ptable**](https://github.com/sdcTools/ptable) for the prototype testing, there are two possibilities.


One is to download the compressed file [**v0.1.13_prototype.tar.gz**](https://github.com/sdcTools/ptable/archive/v0.1.13_prototype.tar.gz) and issue the following command:

```
install_local("/path/to/downloaded/ptable-0.1.13_prototype.tar.gz",
  build_vignette=FALSE, dependencies=TRUE)
```

The second method allows to install the package directly from github without the need to explicitly download a file. This can be done as follows:

```
install_github("sdcTools/ptable", ref="v0.1.13_prototype", build_vignette=FALSE, dependencies=TRUE)
```

If you experience a timeout due to a proxy server while downloading, one can work around this issue by specifying the proxy-server using the httr package:

```
if (!require("httr")) install.packages("httr")
httr::set_config(use_proxy(url="xxx.xxx.xxx.xxx", port=yy))
```


### Using the package
Once the package has been installed, it can be loaded and its functionality can be used. 

```
library(ptable)

params <- pt_create_pParams(D=3, V=0.7)
ptable_destatis <- pt_create_pTable(params = params, type="destatis")
ptable_abs <- pt_create_pTable(params = params, type="abs")

ptable() # GUI
```

Furthermore, all functions are documented and the help-index of the package can be started using

```
help(pa=ptable)
```
However, the documentation is not finished and there is still a to-do list
-   Merge the two main functions `pt_create_pParams(...)` and `pt_create_pTable(...)` into one function
-   Allow for special cases: extended parameter setting, i.e. improved row-wise parameter settings
-   Add theoretical short description
-   Add vignettes (documentation)
-   Add error codes
-   Improved `fifi_...`-functions
-   Add test environment
-   Improve accuracy of ptable by means of digits-functionality
-   Add generic functions in pt\_methods.R, e.g. plot(...)
-   Update optimization for predrawn allocation if `type="abs"`

### Further Information
The package is developed in its seperate github-repository at [**sdcTools/ptable**](https://github.com/sdcTools/ptable) where additional information such as changes between versions are documented.

### Feedback
Feedback (via issues) in the [**issue-tracker**](https://github.com/sdcTools/ptable/issues) with regards to bugs or features requests are welcome as well as pull-requests. Once the package is deemed stable, a version will be released on CRAN too.


*Thx to [@bernhard-da]( https://github.com/bernhard-da ) for his installation instructions I used here as template.
