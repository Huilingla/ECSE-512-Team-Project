function data_symbols = generate_data_symbols(num_symbols, constellation)
% GENERATE_DATA_SYMBOLS Generates random 4-QAM data symbols
%   data_symbols = GENERATE_DATA_SYMBOLS(num_symbols, constellation)
%   generates IID random symbols from the given constellation
%
%   Input:
%       num_symbols - number of symbols to generate
%       constellation - array of constellation points
%   Output:
%       data_symbols - generated symbol sequence

% Generate random indices (1 to M)
M = length(constellation);
symbol_indices = randi([1, M], 1, num_symbols);

% Map indices to constellation points
data_symbols = constellation(symbol_indices);

% Verify statistics
fprintf('Generated %d symbols from %d-QAM constellation\n', ...
    num_symbols, M);
fprintf('Symbol mean: %.4f + %.4fj (should be near 0)\n', ...
    real(mean(data_symbols)), imag(mean(data_symbols)));
fprintf('Symbol power: %.4f (should be near %.4f)\n', ...
    mean(abs(data_symbols).^2), mean(abs(constellation).^2));

end
