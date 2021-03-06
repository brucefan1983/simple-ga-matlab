clear; %close all;

% Call my_snes to evolve
N_neurons = 10;
dim = N_neurons*(N_neurons+4)+1;
[best_fitness, elite] = my_snes(dim, 'ann_snes', 20, 10, 10000);
num_generations = length(best_fitness);

% Evolution of the best fitness:
figure
loglog(1 : num_generations, best_fitness, 'linewidth',2)
xlabel('Generation','fontsize',12);
ylabel('Best Fitness','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);

% Evolution of the best solution:
figure
semilogx(1 : num_generations, elite)
xlabel('Generation','fontsize',12);
ylabel('Best Solution','fontsize',12);
set(gca,'fontsize',12,'ticklength',get(gca,'ticklength')*2);

% compare with the training set:
x0 = 1 : 0.01 : 3;
U0 = 1./x0.^12 - 1./x0.^6;
[y, U] = ann_snes(elite);
figure;
plot(x0, U0, 'o'); hold on;
plot(x0, U(end, :), '-');


