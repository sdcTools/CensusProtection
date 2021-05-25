## CellKey-Method

### Folder-Structure
This directory contains information and links on how-to apply the CellKey method and relevant packages/repositories where further documentation is available.

- Subdirectory `R` contains Information on the `R`-package [**cellKey**](https://github.com/sdcTools/cellKey)
- Subdirectory `ptable` contains Information on the `R`-package [**ptable**](https://github.com/sdcTools/ptable) that is used to generate perturbation tables for [**cellkey**](https://github.com/sdcTools/cellkey) and [**tau-argus**](https://github.com/sdcTools/tauargus).
- Subdirectory `Argus` contains information on the implementation in [**tau-argus**](https://github.com/sdcTools/tauargus) 
- Subdirectory `SAS` contains SAS macros that can be used

### Quick overview: "How to design and apply random noise based on the Cell Key method using the tools in this repository"

The basic steps are:

1. Edit the micro data using your preferred tool (e.g. `SAS` or `R`) and **attach a record key** to each unit/record/observation (e.g. person, household, company, ...) **one time** for the purpose of consistency. 

2. **Design the random noise** according to your preferences (i.e. set the parameters such as maximum noise and variance of the perturbation) using the `ptable`-package to **generate the perturbation table**. 

3. Import the micro data with the attached record keys and create the tables you want to perturb by **adding random noise to the table** using either `Tau-Argus`, the `cellKey`-package or `SAS` macros (for specific steps, please look at the documentation of the respective tool)
    + Define the tables
    + Import the perturbation table
    + Perturb the tables
