function y = fitness_snes(population)
% Get the population size and the number of variables:
[population_size, number_of_variables] = size(population);
% Assume the function to be minimized is y = (x1 - 1)^2 + (x2 - 2)^2 + ...
solution = 1 : number_of_variables;
y = sqrt(mean( (population - repmat(solution, population_size, 1)).^2, 2));
