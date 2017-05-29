function [best_fitness, elite, generation] = my_ga(number_of_variables, fitness_function, ...
    population_size, parent_number, mutation_rate, maximal_generation, minimal_cost)
cumulative_probabilities = cumsum((parent_number:-1:1) / sum(parent_number:-1:1));
best_fitness = ones(maximal_generation, 1);
elite = zeros(maximal_generation, number_of_variables);
child_number = population_size - parent_number;
population = rand(population_size, number_of_variables); % values in [0, 1]
for generation = 1 : maximal_generation
    cost = feval(fitness_function, population);
    [cost, index] = sort(cost);
    population = population(index(1:parent_number), :);
    best_fitness(generation) = cost(1);
    elite(generation, :) = population(1, :);
    if best_fitness(generation) < minimal_cost; break; end
    for child = 1:2:child_number % crossover
        mother = min(find(cumulative_probabilities > rand));
        father = min(find(cumulative_probabilities > rand));
        crossover_point = ceil(rand*number_of_variables);
        mask1 = [ones(1, crossover_point), zeros(1, number_of_variables - crossover_point)];
        mask2 = not(mask1);
        mother_1 = mask1 .* population(mother, :);
        mother_2 = mask2 .* population(mother, :);
        father_1 = mask1 .* population(father, :);
        father_2 = mask2 .* population(father, :);
        population(parent_number + child, :) = mother_1 + father_2;
        population(parent_number+child+1, :) = mother_2 + father_1;
    end
    % mutation
    mutation_population = population(2:population_size, :);
    number_of_elements = (population_size - 1) * number_of_variables;
    number_of_mutations = ceil(number_of_elements * mutation_rate);
    mutation_points = ceil(number_of_elements * rand(1, number_of_mutations));
    mutation_population(mutation_points) = rand(1, number_of_mutations);
    population(2:population_size, :) = mutation_population;
end