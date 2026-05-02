clc;

% Inputs
input = [Iq, Iq_Ref, Id, sin(theta(:,1)), cos(theta(:,1))]; % accuracy of 65% and if data increases reduced to 46%
% input = [Iq, Iq_Ref, Id, sin(theta(:,1)), cos(theta(:,1)), We_PI]; % accuracy of 46%

% Convert logical outputs to double and ensure column vectors
Sa_d = double(Sa(:));
Sb_d = double(Sb(:));
Sc_d = double(Sc(:));

% Create output matrix properly
output = [Sa_d, Sb_d, Sc_d];

% Weighted switching state (binary → decimal)
y = 4*Sa_d + 2*Sb_d + Sc_d;

% Final dataset
%data = [input, y];
data = [input(3: end, :), y(1: end - 2), y(2: end - 1), y(3: end)];

% Verify sin^2 + cos^2 = 1
x = input(:,5).^2 + input(:,4).^2;
tol = 1e-6;
count = sum(abs(x - 1) < tol);

% Write CSV
writematrix(data, "data.csv");
