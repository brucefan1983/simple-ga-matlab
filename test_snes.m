clear; close all;

% Call my_snes to evolve
[best_fitness, elite, generation] = my_snes(10, 'fitness_snes', 100, 50, 1000, 1.0e-10);

% Evolution of the best fitness:
figure
loglog(1 : generation, best_fitness(1 : generation), 'linewidth',2)
xlabel('Generation','fontsize',12);
ylabel('Best Fitness','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);

% Evolution of the best solution:
figure
semilogx(1 : generation, elite(1 : generation, :))
xlabel('Generation','fontsize',12);
ylabel('Best Solution','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);
