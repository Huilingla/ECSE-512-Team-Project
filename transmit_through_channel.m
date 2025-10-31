function [y_received, y_channel, noise] = transmit_through_channel(...
    data_symbols, h, SNR_dB, sigma_s)
% TRANSMIT_THROUGH_CHANNEL Simulates transmission through dispersive channel
%   [y_received, y_channel, noise] = TRANSMIT_THROUGH_CHANNEL(...)
%   applies channel filtering and AWGN
%
%   Input:
%       data_symbols - transmitted symbol sequence
%       h - channel impulse response
%       SNR_dB - signal-to-noise ratio in dB
%       sigma_s - signal power parameter
%   Output:
%       y_received - received signal after channel and noise
%       y_channel - signal after channel (before noise)
%       noise - generated AWGN noise

% Apply channel filtering
y_channel = conv(data_symbols, h, 'same');

% Calculate noise variance based on SNR
% For complex signals: SNR = E[|x|^2] / E[|w|^2]
signal_power = mean(abs(y_channel).^2);
SNR_linear = 10^(SNR_dB/10);
noise_variance = signal_power / SNR_linear;

% Generate complex AWGN noise
% Real and imaginary parts are independent N(0, noise_variance/2)
noise_std = sqrt(noise_variance/2);
noise = noise_std * (randn(size(y_channel)) + 1j*randn(size(y_channel)));

% Add noise to channel output
y_received = y_channel + noise;

fprintf('Transmission through channel:\n');
fprintf('  Channel length: %d taps\n', length(h));
fprintf('  Signal power: %.4f\n', signal_power);
fprintf('  Noise variance: %.6f\n', noise_variance);
fprintf('  Noise power: %.6f\n', mean(abs(noise).^2));

end
