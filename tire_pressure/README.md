# Tire pressure kata

The tire pressure kata is used to practise dealing with external dependencies.

## Stuff to add

- A class that is the sensor. 
- A class that is the alarm, that uses the sensor.
- A solution

In version 1 the sensor has no interface, only a type and is created inside
the alarm. 
It has tests, but they are flaky.

The goal is to create an interface to the sensor, 
so that it can be exchanged for a test double,
and then pass it as a dependency, either to the object or the function.

