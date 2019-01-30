## Installing R-Package `recordSwapping`

### Directly from R

```
install.packages("devtools")
remotes::install_github(
  repo = "sdcTools/recordSwapping",
  ref="recordSwapping_prototype",
  build_opts = c("--no-resave-data", "--no-manual")
)
```

### Dowloading .tar.gz and install locally

+ Download .tar.gz-File under https://github.com/sdcTools/recordSwapping/archive/recordSwapping_prototype.tar.gz.
+ Open a terminal window and go to the directory that contains the .tar.gz-File (with `cd`).
+ When you are at the desired directory type

```
R CMD INSTALL recordSwapping-recordSwapping_prototype.tar.gz
```

Afterwards start R and type `library(recordSwapping)` to load the package into the R-Session.

### Using the package

The package `recordSwapping` contains a vignette which can be called through:

```
library(recordSwapping)
vignette("recordSwapping")
```

The vignette contains all the informations needed to get started with the package.

### Further Information
The package is developed in its seperate github-repository at [**sdcTools/recordSwapping**](https://github.com/sdcTools/recordSwapping) where additional information such as changes between versions are documented.

### Feedback
Feedback (via issues) in the [**issue-tracker**](https://github.com/sdcTools/recordSwapping/issues) with regards to bugs or features requests are welcome as well as pull-requests. One the package is deemed stable, it will be included into package [**sdcTools/sdcMicro**](https://github.com/sdcTools/sdcMicro).