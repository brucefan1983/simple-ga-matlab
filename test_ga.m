clear; close all;

% Call my_ga to evolve
[best_fitness, elite, generation] = my_ga(10, 'my_fitness', 100, 50, 0.1, 10000, 1.0e-4);

% Decode according to the fitness function
best_solution = (2 * elite(1 : generation, :) - 1) * 20; 

% Evolution of the best fitness:
figure
loglog(1 : generation, best_fitness(1 : generation), 'linewidth',2)
xlabel('Generation','fontsize',12);
ylabel('Best Fitness','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);

% Evolution of the best solution:
figure
semilogx(1 : generation, best_solution)
xlabel('Generation','fontsize',12);
ylabel('Best Solution','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);
