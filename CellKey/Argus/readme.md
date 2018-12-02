## Installation of tau-Argus 4.1.12BETA build 2

This document will help you to install and use [**tau-Argus**](https://github.com/sdcTools/tauargus) that has the Cell Key Method as one of the available tabular data protection methods.

### Prerequisites
In order to be able to apply the Cell Key Method from tau-argus, you first need to add a variable to you microdata file containing so called record keys (Uniform(0,1) realisations). This should be done **one time** per microdata file to ensure consistency between tables resulting from different runs of tau-argus on the same microdata file.

Additionally you need a so-called p-table that defines the distribution of the noise to be added. To that end you can make use of the [**ptable**](https://github.com/sdcTools/ptable) package. For tau-argus you need to save the p-table in `destatis`-format (see documentation of the [**ptable**](https://github.com/sdcTools/ptable) package).

### Installing tau-Argus
To install the prototype for testing in a Windows based environment, download the compressed file [**tau_argus 4.1.12BETA build 2**](https://github.com/sdcTools/tauargus/releases/download/4.1.12_BETA_build2/TauArgus4.1.12BETA_build2.zip). Unzip this file into a directory where you have write permission. 

### Using the package
In the directory where you unzipped the compressed file, you will find 

<img src="https://github.com/sdcTools/tauargus/blob/master/src/tauargus/resources/Tau32.png" height="24"> `TauArgus.exe` 

Just start that program and you can start using tau-argus.

Further information specifically on the use of the Cell Key Method can be found in the [**Quick Reference**](https://github.com/sdcTools/tauargus/releases/download/4.1.12_BETA_build2/QuickReferenceCKM4.1.12.3.pdf).

### Feedback
Feedback (via issues) in the [**issue-tracker**](https://github.com/sdcTools/UserSupport/issues) with regards to bugs or feature requests are welcome.
