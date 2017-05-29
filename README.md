# simple-ga-matlab

A 50-line MATLAB implementation of a simple genetic algorithm (GA) with real-value chromosome. 

## Features

* This is a small but working GA code, which is particularly useful to beginners. 
  Actually, I have used it in one of my published journal articles. 
  
## File organizations

* There is one script:
  * test_ga.m

* This script will call the "my_ga" function in
  * my_ga.m
  
* The above function will in turn call the "my_fitness" function in
  * my_fitness.m
  
## Example

* The cost (fitness) function defined in the "my_fitness" function is 
   ```math 
   y = (x_1 - 1)^2 + (x_2 - 2)^2 + ...
   ```
  We know that the "correct solution" is 
   ```math 
   x_i = i (i = 1, 2, ...)
   ```
  
* Running the "test_ga.m" script in MATLAB, two figures will show up after a few seconds.
  * The first figure shows the evolution of the cost function with respect to the generation.
  * The second figure shows the evolution of the elite (best solution) with respect to the generation.
    As expectd, the best solution converges to the correct solution.

## Contact

* Zheyong Fan: brucenju(at)gmail.com; zheyong.fan(at)aalto.fi; zheyongfan(at)163.com
