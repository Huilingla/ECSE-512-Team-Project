function constellation = get_4qam_constellation(sigma_s)
% GET_4QAM_CONSTELLATION Generates 4-QAM constellation points
%   constellation = GET_4QAM_CONSTELLATION(sigma_s) returns the 4-QAM
%   constellation points with given signal power parameter
%
%   Input:
%       sigma_s - signal power parameter
%   Output:
%       constellation - 4-QAM constellation points [s1, s2, s3, s4]

% Generate 4-QAM constellation points according to project specification
constellation = (sigma_s/sqrt(2)) * [1+1j, -1+1j, -1-1j, 1-1j];

end
