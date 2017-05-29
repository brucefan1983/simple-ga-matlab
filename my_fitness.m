function y = my_fitness(population)
% Get the population size and the number of variables:
[population_size, number_of_variables] = size(population);
% Assume each variable is within the range of [-20, 20].
population = (2 * population - 1) * 20;
% Assume the function to be minimized is y = (x1 - 1)^2 + (x2 - 2)^2 + ...
y = sum( (population - kron(ones(population_size, 1), 1 : number_of_variables)).^2, 2);
