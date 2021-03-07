clear; close all;

% Call my_ga to evolve
N_neurons = 10;
dim = N_neurons*(N_neurons+4)+1;
[best_fitness, elite, generation] = my_ga(dim, 20, 10, 0.01, 10000);

% Decode according to the fitness function
best_solution = (2 * elite(1 : generation, :) - 1) * 10; 

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

% compare with the training set:
x0 = 1 : 0.01 : 3;
[y, U, U0] = ann(elite, 20, -10);
figure;
plot(x0, U0, 'o'); hold on;
plot(x0, U(end, :), '-');

