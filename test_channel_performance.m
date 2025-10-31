function test_channel_performance(h, channel_name)
% TEST_CHANNEL_PERFORMANCE Tests and displays channel characteristics
%   TEST_CHANNEL_PERFORMANCE(h, channel_name) analyzes channel properties
%
%   Input:
%       h - channel impulse response
%       channel_name - descriptive name for the channel

fprintf('  %s:\n', channel_name);
fprintf('    Impulse response: [');
fprintf('%.3f ', h);
fprintf(']\n');
fprintf('    Energy: %.6f\n', sum(abs(h).^2));
fprintf('    Length: %d taps\n', length(h));

% Check if it's a pure delay channel
if sum(abs(h)) == 1 && nnz(h) == 1
    delay = find(h == 1, 1) - 1;
    fprintf('    Type: Pure delay (n0 = %d)\n', delay);
else
    fprintf('    Type: Dispersive (causes ISI)\n');
end

end
