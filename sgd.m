clear; close all;
x0 = 1 : 0.01 : 3;
U0 = 1./x0.^12 - 1./x0.^6;
N_samples = length(x0);
N_neurons = 5;
u = (rand(N_neurons, 1) - 0.5)/sqrt(N_neurons);
v = (rand(N_neurons, N_neurons) - 0.5)/sqrt(N_neurons);
w = (rand(1, N_neurons) - 0.5)/sqrt(N_neurons);
a = (rand(N_neurons, 1) - 0.5)/sqrt(N_neurons);
b = (rand(N_neurons, 1) - 0.5)/sqrt(N_neurons);
c = rand - 0.5;
learning_rate = 0.01; % the learning rate
N_steps = 100000;
rmse_U = zeros(N_steps, 1);
for step = 1 : N_steps % loop over the training steps
    if mod(step, 1000) == 0; disp(step); end;
    x = x0; % input layer
    y = zeros(N_neurons, N_samples); % 1st hidden layer
    yd = zeros(N_neurons, N_samples); % 1st hidden layer
    z = zeros(N_neurons, N_samples); % 2nd hidden layer
    zd = zeros(N_neurons, N_samples); % 2nd hidden layer
    U = zeros(1, N_samples); % output layer
    Ud = zeros(1, N_samples); % output layer
    for n_sample = 1 : N_samples % loop over the samples
        y(:, n_sample) = tanh(u * x(n_sample) - a);
        yd(:, n_sample) = 1 - y(:, n_sample) .* y(:, n_sample);
        z(:, n_sample) = tanh(v * y(:, n_sample) - b);
        zd(:, n_sample) = 1 - z(:, n_sample) .* z(:, n_sample);
        U(n_sample) = w * z(:, n_sample) - c;
        Ud(n_sample) = w * zd(:, n_sample);
        deltaU = U(n_sample) - U0(n_sample);
        dEdw = deltaU * z(:, n_sample).';
        dEdc = -deltaU;
        dEdv = deltaU * (w.' .* zd(:, n_sample)) * y(:, n_sample).';
        dEdb = -deltaU * w.' .* zd(:, n_sample);
        dEdu = deltaU * x(n_sample) * yd(:, n_sample) .* (v.' * zd(:, n_sample) .* w.');
        dEda = -deltaU * yd(:, n_sample) .* (v.' * zd(:, n_sample) .* w.');
        eta = learning_rate;
        u = u - eta * dEdu;
        v = v - eta * dEdv;
        w = w - eta * dEdw;
        a = a - eta * dEda;
        b = b - eta * dEdb;
        c = c - eta * dEdc;
    end
    rmse_U(step) = sqrt(mean((U - U0).^2));
end

figure;
plot(1:N_steps, rmse_U, '-');
xlabel('Step', 'fontsize', 15);
ylabel('Loss', 'fontsize', 15);

figure;
plot(x0, U0, 'ro');
hold on;
plot(x0, U, 'bx');
legend('training data');
xlabel('x', 'fontsize', 15);
ylabel('y', 'fontsize', 15);
set(gca, 'fontsize', 15);
legend('raw', 'fit');