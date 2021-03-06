function [best_fitness, elite, generation] = my_snes(number_of_variables, fitness_function, ...
    population_size, parent_number, maximal_generation, minimal_cost)
best_fitness = ones(maximal_generation, 1);
elite = zeros(maximal_generation, number_of_variables);
mu = rand(1, number_of_variables); % initial mean
sigma = ones(1, number_of_variables); % initial variance
learn_rates = [1, (3 + log(number_of_variables))/(5 * sqrt(number_of_variables)) / 2];
utility = (parent_number:-1:1) / sum(parent_number:-1:1);
for generation = 1 : maximal_generation
    s = randn(population_size, number_of_variables);
    population = repmat(mu, population_size, 1) + repmat(sigma, population_size, 1) .* s;
    cost = feval(fitness_function, population);
    [cost, index] = sort(cost);
    
    best_fitness(generation) = cost(1);
    
    elite(generation, :) = population(1, :);
    disp(elite(generation, :))
    if best_fitness(generation) < minimal_cost; break; end
    s = s(index(1 : parent_number), :);
    mu = mu + learn_rates(1) * sigma .* (utility * s); % update mean
    sigma = sigma .* exp(learn_rates(2) * (utility * (s .* s - 1))); % update variance
end
