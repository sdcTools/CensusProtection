This directory contains prototypes for applying the CellKey method

Subdirectory `R` contains the R script version

Subdirectory `Argus` contains tau-argus version 

Subdirectory `ptable` contains the ptable R-package

Subdirectory `SAS` contains SAS macros

## Quick overview: How to design and apply random noise based on the Cell Key method using the tools in this repository

Here are the steps:

1. Edit the microdata using your preferred tool (e.g. SAS or R) and **attach a record key** to each unit/record/observation (e.g. person, household, company, ...) **one time** for the purpose of consistency:
    + if `R`: see the documentation of the R-package `cellKey`
    + if `SAS`: use the provided SAS macro available in the subdirectory `SAS`

2. **Design the random noise** according to your preferences (i.e. set the parameters such as maximum noise and variance of the perturbation) using the `ptable`-package to **generate the perturbation table**. 
    + **NOTE:** Please use the destatis-format when you design the random noise and export the perturbation table: i.e., `pt_create_pTable(...,type="destatis")`

3. Import the mirodata with the attached record keys and create the tables you want to perturb by **adding random noise to the table** using either `Tau-Argus`, the `cellKey`-package or `SAS`
    + Define the tables (see the documentation of the respective tool) 
    + Import the perturbation table
        + if `Tau-Argus` or `SAS`: use the perturbation table you generated and exported in step 2 as csv-file (see documentation of the `ptable`-package) 
        + if `cellKey`-package: either use the result of the `ptable`-package within R as input or use the built-in functionality of the `cellKey` package which makes use of the `ptable` package
    + Perturb the tables (see the documentation of the respective tool) 
