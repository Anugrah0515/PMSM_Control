figure;

plot(We_ANN, 'LineWidth', 1.5);
hold on;
plot(We_MPC, 'LineWidth', 1.5);
plot(We_PI, 'LineWidth', 1.5);

xlabel('Time');
ylabel('Speed');
title('Comparison of Speed Response');
legend('ANN', 'MPC', 'PI');
grid on;
hold off;

figure;

plot(We_MPC, 'LineWidth', 1.5);
hold on;
plot(We_MPC_Switching, 'LineWidth', 1.5);

xlabel('Time');
ylabel('Speed');
title('Comparison of MPC and Switching Loss Optimized MPC');
legend('MPC', 'Switching Loss Opt');
grid on;
hold off;


figure;

plot(We_ANN, 'LineWidth', 1.5);
hold on;
plot(We_ANN_Dense, 'LineWidth', 1.5);

xlabel('Time');
ylabel('Speed');
title('Comparison of Different Architectures');
legend('Light Network', 'Dense Network');
grid on;
hold off;