function h = get_channel_response(channel_type, varargin)
% GET_CHANNEL_RESPONSE Generates different channel impulse responses
%   h = GET_CHANNEL_RESPONSE(channel_type, ...) returns normalized channel
%
%   Input:
%       channel_type - 'delay', 'mild_isi', 'severe_isi', or 'custom'
%       varargin - additional parameters (e.g., delay for 'delay' type)
%   Output:
%       h - normalized channel impulse response (unit energy)

switch lower(channel_type)
    case 'delay'
        % Pure delay channel: h[n] = δ[n - n0]
        if nargin > 1
            delay = varargin{1};
        else
            delay = 2; % default delay
        end
        h = zeros(1, delay+1);
        h(end) = 1;
        
    case 'mild_isi'
        % Mild inter-symbol interference
        h = [0.2, 1.0, 0.2, -0.1];
        
    case 'severe_isi'
        % Severe inter-symbol interference
        h = [0.5, 1.0, 0.5, -0.3, 0.2];
        
    case 'custom'
        % Custom channel - user provided coefficients
        if nargin > 1
            h = varargin{1};
        else
            error('Custom channel requires coefficients as second argument');
        end
        
    otherwise
        error('Unknown channel type: %s', channel_type);
end

% Normalize channel to have unit energy
h = h(:)'; % ensure row vector
channel_energy = sum(abs(h).^2);
h = h / sqrt(channel_energy);

fprintf('Channel coefficients: [');
fprintf('%.3f ', h);
fprintf(']\n');
fprintf('Channel energy: %.6f (should be 1.000)\n', sum(abs(h).^2));

end
