# Actuator Disc Momentum Theory with Inverse Formulation
This repository contains some implementations of classic momentum theory. The primary purpose is to encode the equations for the inverse form that is able to, without solving iteratively, calculate thrust as a function of induced power (classic momentum theory is only able to find induced power as a function of thrust).

## Inverse formulation

![](http://latex.codecogs.com/png.latex?T=\left(\kappa\alpha\right)^{^1/_3}-\frac{2}{3}V_0\beta^{^1/_3}),

where 

![](http://latex.codecogs.com/png.latex?\alpha={P_i}^{^3/_2}\sqrt{\mu+{P_i}}+{P_i}^2), 

![](http://latex.codecogs.com/png.latex?\beta=\frac{\kappa^2{P_i}}{1+\sqrt{\frac{\mu}{P_i}+1}}), 

![](http://latex.codecogs.com/png.latex?\kappa=\rho%20A), and 

![](http://latex.codecogs.com/png.latex?\mu=\kappa\left(\frac{2}{3}V_0\right)^3).

## Repository summary
Because it may be difficult to encode the inverse form without typographical errors, it is implemented here for convenience in three formats:
- Python: `actuator_disc.py` module
- Matlab: `+actuator_disc` package
- Excel and VBA: `actuator_disc.xlsx`

Each format contains four elements:
- Thrust as a function of power
- Power as a function of thrust
- Induced velocity calculation
- A demo / test

Refer to the Matlab functions for the most features and per-element documentation: `>> help actuator_disc` 

## To run
To run the demo / test:
- Python: `$ python actuator_disc.py`
- Matlab: `>> actuator_disc.demo`
- Excel / VBA: open workbook

## Cite as
Sky Sartorius (2019). Actuator Disc Momentum Theory with Inverse Formulation (https://www.github.com/sky-s/physical-units-for-matlab), GitHub. Retrieved MMM DD, YYYY.

#
Copyright (c) 2013-2019, Sky Sartorius
