"""Actuator disc momentum theory functions.

Notes:
disc_efficiency is used here as the efficiency of shaft power inducing flow,
i.e., induced_power/shaft_power, which captures losses from swirl and viscous
effects.

There is no unit conversion, so units must be consistent, e.g. power in
ft-lbf/s instead of horsepower."""

# Copyright Sky Sartorius.

import numpy as np


def induced_velocity(thrust, density, area, velocity=0):
    """Actuator disc induced velocity calculation (classic momentum theory)."""
    return -velocity / 2 + np.sqrt((velocity / 2)**2
                                   + thrust / (2 * density * area))


def thrust(shaft_power, density, area, velocity=0, disc_efficiency=1):
    """Actuator disc thrust calculation (inverse classic momentum theory)."""
    induced_power = shaft_power * disc_efficiency
    k = np.sqrt(3 * induced_power**3 * (
                8 * area * density * velocity**3 + 27 * induced_power)) \
        + 9 * induced_power**2

    return (k**(2 / 3) / 3 - (2 * induced_power * velocity *
                              (3 * area * density)**(1 / 3)) / 3) \
        * ((3 * area * density) / k)**(1 / 3)


def power(thrust, density, area, velocity=0, disc_efficiency=1):
    """Actuator disc power calculation (classic momentum theory)."""
    induced_power = thrust * \
        (velocity + induced_velocity(thrust, density, area, velocity))
    shaft_power = induced_power / disc_efficiency
    return shaft_power


def propeller_efficiency(thrust, shaft_power, velocity):
    """Efficiency of converting shaft power to thrust power."""
    return thrust * velocity / shaft_power


def ideal_efficiency(induced_velocity, velocity):
    """Momentum theory ideal efficiency."""
    return velocity / (velocity + induced_velocity)


if __name__ == "__main__":
    """Validate the inverse equations."""
    n = 100000
    print("Checking inverse equations with %i random input sets..." % n)
    density = np.random.rand(n)  # kg/m^3
    area = np.random.rand(n)  # m^2
    disc_efficiency = np.random.rand(n)
    velocity = np.random.rand(n)  # m/s
    thrust_1 = np.random.rand(n)  # N

    shaft_power = power(thrust_1, density, area, velocity, disc_efficiency)
    thrust_2 = thrust(shaft_power, density, area, velocity, disc_efficiency)

    err = thrust_2 - thrust_1
    print("Max error: %g" % max(abs(err)))
