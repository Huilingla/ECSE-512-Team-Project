%% ECSE 512 Project: System Architect (Part 1)
% This script demonstrates the transmitter and channel components
clear; close all; clc;

%% System Parameters
params.M = 4;                           % 4-QAM
params.sigma_s = 1;                     % Signal power parameter
params.NumSymbols = 5000;               % Total number of symbols to transmit
params.TrainingLength = 1000;           % Length of training sequence
params.SNR_dB = 20;                     % Signal-to-Noise Ratio (dB)
params.NumMonteCarloRuns = 5;          % Number of Monte Carlo runs

% Display parameters
fprintf('=== System Parameters ===\n');
fprintf('Modulation: %d-QAM\n', params.M);
fprintf('Number of symbols: %d\n', params.NumSymbols);
fprintf('Training sequence length: %d\n', params.TrainingLength);
fprintf('SNR: %.1f dB\n', params.SNR_dB);
fprintf('Monte Carlo runs: %d\n', params.NumMonteCarloRuns);

%% Generate 4-QAM Constellation
constellation = get_4qam_constellation(params.sigma_s);
fprintf('\n4-QAM Constellation Points:\n');
disp(constellation);

%% Generate and Test Different Channels
fprintf('\n=== Channel Testing ===\n');

% Test Case 1: Pure Delay (Ideal channel)
fprintf('Test 1: Pure Delay Channel\n');
h_delay = get_channel_response('delay', 3);
test_channel_performance(h_delay, 'Pure Delay Channel');

% Test Case 2: Mild ISI
fprintf('Test 2: Mild ISI Channel\n');
h_mild = get_channel_response('mild_isi');
test_channel_performance(h_mild, 'Mild ISI Channel');

% Test Case 3: Severe ISI
fprintf('Test 3: Severe ISI Channel\n');
h_severe = get_channel_response('severe_isi');
test_channel_performance(h_severe, 'Severe ISI Channel');

%% Generate Sample Transmission for Visualization
fprintf('\n=== Generating Sample Transmission ===\n');

% Use severe ISI channel for demonstration
h = h_severe;

% Generate random data symbols
data_symbols = generate_data_symbols(params.NumSymbols, constellation);

% Transmit through channel
[y_received, y_channel, noise] = transmit_through_channel(...
    data_symbols, h, params.SNR_dB, params.sigma_s);

% Calculate actual SNR
actual_SNR = 10*log10(var(y_channel) / var(noise));
fprintf('Theoretical SNR: %.1f dB, Actual SNR: %.1f dB\n', ...
    params.SNR_dB, actual_SNR);

%% Visualization
plot_system_architect_results(data_symbols, y_received, constellation, h);

fprintf('\n=== System Architect Tasks Complete ===\n');
fprintf('Ready to pass received signal to Equalizer team member.\n');
