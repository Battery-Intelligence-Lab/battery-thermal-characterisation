# Anisotropic thermal-conductivity characterisation with thermography

Please see [our open access paper](https://doi.org/10.1002/batt.202100401) (also available as a [preprint](https://arxiv.org/abs/2112.09768)) that describes this work. We propose a novel thermal characterisation approach for measuring the anisotropic thermal conductivity of large-format lithium-ion pouch cells with infrared thermography. An optimization algorithm was developed, with codes provided in this repository, to characterize the three-dimensional thermal conductivity of Li-ion pouch cells.

## Experiment

The experiment was conducted by placing pouch cells to be tested horizontally on a cell holder. A customized circular polyimide heater was affixed to the geometric centre of the largest rectangular face of the cell, which was oriented downward. A thermocouple, that had been previously calibrated, was placed at the centre of the heater. The whole back surface was then well insulated. A thermal imaging camera was fixed at the top of the test rig to record the surface-temperature response upon heating. Additional RTD probes were positioned near the cell holder to record the ambient temperature and were used as a reference for the camera. The heater was connected to a bespoke control circuit which regulated power to ensure a constant surface temperature. Taking the thermocouple reading as the feedback signal, a proportional–integral–derivative (PID) control program was executed to fix a constant thermocouple temperature. The temperature setpoint was generally reached on a very short timescale (order seconds). 

## Characterization

The effective thermal conductivity within the battery cell can be characterized by inverse modelling using numerical simulations. Generally the thermal response of the cell follows an energy balance described by the heat equation. A thermal model was established and solved numerically with COMSOL Multiphysics software, assuming that the battery was initially at ambient temperature, and using the actual heating temperature recorded by the heater controller as a transient heat input to the cell on a small circular surface. These simulations produce the transient surface-temperature distribution on the surface of the cell opposite the heater as functions of the ambient temperature, heat-transfer coefficient, volumetric battery heat capacity, and the three thermal-conductivity tensor components. To fit the thermal conductivity, a uniform 11x11 matrix of surface temperature points was defined around the heater centre, for a total of 121 points across the cell surface. A nonlinear least-squares optimization algroithm was used in MATLAB, and the sum of the discrepancies between the experimental and simulated temperatures was taken as the objective function to be minimized.

## Using the code

The optimization algorithm was developed using MATLAB, which calls the battery model for numerical simulation in COMSOL. The codes are to be run with COMSOL Livelink interface with MATLAB. The codes mainly contain three scripts, i.e., `Main_Opt.m`, `ObjFunc.m` and `Batterymodel.m`, and they are described as follows:
- **Main_Opt:** Define the nonliear least-squares optimization algorithm for thermal conductivity optimization.
- **ObjFunc:** Load experimental data and simulation results from battery model to calculate the objective function.
- **Batterymodel:** is the battery thermal model developed in COMSOL and exported as .m file, to be run by COMSOL livelink with MATLAB.
In addition to the scripts, a set of experimental data is also provided for fitting.
