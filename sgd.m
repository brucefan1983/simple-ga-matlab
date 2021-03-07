clear; %close all;

use_batch = false;

% the training data set
x0 = 1 : 0.01 : 3;
N_samples = length(x0);
U0 = 10./x0.^12 - 10./x0.^6 + rand(1, N_samples) * 0.1;
U = zeros(1, N_samples);

% initialize the NN parameters
N_neurons = 10; % 1-10-10-1 NN
u = (rand(N_neurons, 1) - 0.5)*5;
v = (rand(N_neurons, N_neurons) - 0.5)*5;
w = (rand(1, N_neurons) - 0.5)*5;
a = (rand(N_neurons, 1) - 0.5)*5;
b = (rand(N_neurons, 1) - 0.5)*5;
c = (rand - 0.5)*5;

learning_rate = 0.01; % should be relatively large for batch GD
if use_batch
    learning_rate = 0.1;
end

N_steps = 100000;
rmse_U = zeros(N_steps, 1);
for step = 1 : N_steps
    % derivatives of the error wrt weights and biases
    dEdw = zeros(1, N_neurons);
    dEdv = zeros(N_neurons, N_neurons);
    dEdu = zeros(N_neurons, 1);
    dEdc = 0;
    dEdb = zeros(N_neurons, 1);
    dEda = zeros(N_neurons, 1);
    for n_sample = 1 : N_samples
        % propagate the NN forward
        y = tanh(u * x0(n_sample) - a);
        yd = 1 - y .* y;
        z = tanh(v * y - b);
        zd = 1 - z .* z;
        U(n_sample) = w * z - c;
        % calculate the derivatives
        deltaU = U(n_sample) - U0(n_sample);
        dEdw0 = deltaU * z.';
        dEdc0 = - deltaU;
        dEdv0 = deltaU * (w.' .* zd) * y.';
        dEdb0 = - deltaU * w.' .* zd;
        dEdu0 = deltaU * x0(n_sample) * yd .* (v.' * zd .* w.');
        dEda0 = - deltaU * yd .* (v.' * zd .* w.');
        if use_batch
            dEdw = dEdw + dEdw0;
            dEdc = dEdc + dEdc0;
            dEdv = dEdv + dEdv0;
            dEdb = dEdb + dEdb0;
            dEdu = dEdu + dEdu0;
            dEda = dEda + dEda0;
        else
            u = u - learning_rate * dEdu0;
            v = v - learning_rate * dEdv0;
            w = w - learning_rate * dEdw0;
            a = a - learning_rate * dEda0;
            b = b - learning_rate * dEdb0;
            c = c - learning_rate * dEdc0;
        end
    end
    if use_batch
        eta = learning_rate  / N_samples;
        u = u - eta * dEdu;
        v = v - eta * dEdv;
        w = w - eta * dEdw;
        a = a - eta * dEda;
        b = b - eta * dEdb;
        c = c - eta * dEdc;
    end
    
    rmse_U(step) = sqrt(mean((U - U0).^2));
    if mod(step, 1000) == 0
        disp(['Step = ', num2str(step), ', best fitness = ', num2str(rmse_U(step))]);
    end
end

figure;
semilogy(1:N_steps, rmse_U, '-');

figure;
plot(u); hold on;plot(v);plot(w);plot(a);plot(b);plot(c);

figure;
plot(x0, U0, 'ro');
hold on;
plot(x0, U, 'bx');
legend('training data');
xlabel('x', 'fontsize', 15);
ylabel('y', 'fontsize', 15);
set(gca, 'fontsize', 15);
legend('raw', 'fit');
