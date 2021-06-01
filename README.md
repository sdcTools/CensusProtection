<!-- README.md is generated from README.Rmd. Please edit that file -->

# protoTestCensus

This repository was created in order to guide census experts to test
prototype software versions of targeted record swapping and the cell-key
method for Census tables. Over time, the information in this repository
became outdated as the developed methods have been included in different
software packages/tools. So this document now refers to the most
up-to-date documentation for the respective tools.

## How to use the open-source versions of the recommended census protection methods

(This text is also available as a
[**`pdf`**](https://github.com/sdcTools/protoTestCensus/blob/master/How_to.pdf).)

In the previous Specific Grant Agreement - partly funded by
[**`Eurostat`**](https://ec.europa.eu/eurostat/cros/content/harmonised-protection-census-data_en)
- called *“Harmonised protection of CENSUS data in the ESS”* methods
have been developed and tested. In deliverables 3.3 and 3.4
recommendations were given on how to protect the hypercubes and the grid
data in the next Census. The two methods (record swapping and the cell
key method) can be applied independently from each other.

However, with the SAS codes tested in this previous SGA, it was more
straightforward to implement the cell key method. That is why part of
the work in a new SGA (also partly funded by
[**`Eurostat`**](https://ec.europa.eu/eurostat/cros/content/perturbative-confidentiality-methods_en))
called *“Open source tools for perturbative confidentiality methods”* is
to implement these methods in the open-source software R and Argus. This
was done in the last eight months, some tests were carried out by the
SGA members and now we would like to invite census experts to try the
new implementations. They can be downloaded on the respective
Github-repositories which will be linked from this document.

Part 1 is related to targeted record swapping while part 2 focuses on
the cell-key method. The methods can be used independently: it is either
possible to compute unperturbed hypercubes with swapped microdata (part
2 can be ignored), perturbed hypercubes with original microdata (part 1
can be skipped), or perturbed hypercubes with swapped microdata (part 1
then part 2).

### Part 1: Targeted record swapping

To apply record swapping to original microdata it is possible to use
either the `R` package
[`recordSwapping`](https://github.com/sdcTools/recordSwapping)
(paragraph 1.1) or [`MuARGUS`](https://github.com/sdcTools/muargus)
(paragraph 1.2).

Both implementation use the same underlying new C++ code which is
optimized to be incredibly fast. This new implementation of the targeted
record swapping method is intended to be very close to the SAS codes
tested in the previous SGA based on the ONS codes. More information
regarding the small differences can be found in the vignette of the
[`recordSwapping`](https://github.com/sdcTools/recordSwapping) package.

#### 1.1 R-package recordSwapping

The package is developed at
[`github.com/sdcTools/recordSwapping`](https://github.com/sdcTools/recordSwapping)
where also installation instructions and example usage as well as an
introductory vignette can be found.

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

#### 2.3 TauARGUS

The latest release of [`TauArgus`](https://github.com/sdcTools/tauargus)
that includes the implementation of the cellKey method is available at
[`github.com/sdcTools/tauargus/releases`](https://github.com/sdcTools/tauargus/releases)
where also a quick reference documentation with explanations and
screenshots can be downloaded.
