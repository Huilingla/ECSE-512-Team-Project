function plot_system_architect_results(data_symbols, y_received, constellation, h)
% PLOT_SYSTEM_ARCHITECT_RESULTS Creates visualization plots
%   PLOT_SYSTEM_ARCHITECT_RESULTS(data_symbols, y_received, constellation, h)
%   creates constellation plots and channel visualization

figure('Position', [100, 100, 1200, 800]);

% Subplot 1: Transmitted Constellation
subplot(2, 3, 1);
plot(real(data_symbols(1:1000)), imag(data_symbols(1:1000)), '.', ...
    'MarkerSize', 2, 'Color', [0.2, 0.6, 0.8]);
hold on;
plot(real(constellation), imag(constellation), 'ro', ...
    'MarkerSize', 8, 'LineWidth', 2, 'MarkerFaceColor', 'red');
grid on; axis equal;
title('Transmitted 4-QAM Constellation');
xlabel('In-Phase'); ylabel('Quadrature');
legend('Data Symbols', 'Constellation Points', 'Location', 'best');

% Subplot 2: Received Signal (Before Equalization)
subplot(2, 3, 2);
plot(real(y_received(1:1000)), imag(y_received(1:1000)), '.', ...
    'MarkerSize', 2, 'Color', [0.8, 0.4, 0.2]);
hold on;
plot(real(constellation), imag(constellation), 'ro', ...
    'MarkerSize', 8, 'LineWidth', 2, 'MarkerFaceColor', 'red');
grid on; axis equal;
title('Received Signal (Before Equalization)');
xlabel('In-Phase'); ylabel('Quadrature');
legend('Received Samples', 'Ideal Points', 'Location', 'best');

% Subplot 3: Channel Impulse Response
subplot(2, 3, 3);
stem(0:length(h)-1, abs(h), 'filled', 'LineWidth', 2, 'Color', [0.1, 0.5, 0.2]);
title('Channel Impulse Response |h[n]|');
xlabel('Tap Index n'); ylabel('Magnitude');
grid on;

% Subplot 4: Real Part of Signals
subplot(2, 3, 4);
n_plot = 1:100;
plot(n_plot, real(data_symbols(n_plot)), 's-', 'LineWidth', 1.5, ...
    'Color', [0.2, 0.6, 0.8], 'MarkerSize', 4);
hold on;
plot(n_plot, real(y_received(n_plot)), '^-', 'LineWidth', 1, ...
    'Color', [0.8, 0.4, 0.2], 'MarkerSize', 4);
title('Real Part: Transmitted vs Received');
xlabel('Time Index n'); ylabel('Amplitude');
legend('Transmitted', 'Received', 'Location', 'best');
grid on;

% Subplot 5: Imaginary Part of Signals
subplot(2, 3, 5);
plot(n_plot, imag(data_symbols(n_plot)), 's-', 'LineWidth', 1.5, ...
    'Color', [0.2, 0.6, 0.8], 'MarkerSize', 4);
hold on;
plot(n_plot, imag(y_received(n_plot)), '^-', 'LineWidth', 1, ...
    'Color', [0.8, 0.4, 0.2], 'MarkerSize', 4);
title('Imaginary Part: Transmitted vs Received');
xlabel('Time Index n'); ylabel('Amplitude');
legend('Transmitted', 'Received', 'Location', 'best');
grid on;

% Subplot 6: Signal Statistics
subplot(2, 3, 6);
stats_data = [mean(abs(data_symbols).^2), std(real(data_symbols))^2, std(imag(data_symbols))^2;
              mean(abs(y_received).^2), std(real(y_received))^2, std(imag(y_received))^2];
bar(stats_data);
set(gca, 'XTickLabel', {'Transmitted', 'Received'});
ylabel('Power');
title('Signal Power Statistics');
legend('Total Power', 'I Power', 'Q Power', 'Location', 'best');
grid on;

sgtitle('System Architect: Transmitter and Channel Analysis');

end
