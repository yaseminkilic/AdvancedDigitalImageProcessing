function H = highpassFilter(type, M, N, D0, n)
% 'ideal'     Ideal highpass filter with positive cutoff frequency D0
% 'btw'       Butterworth highpass filter of order n, and positive cutoff D0
% 'gaussian'  Gaussian highpass filter with positive cutoff (standard deviation) D0

% The transfer function Hhp of a highpass filter is 1 - Hlp,
% where Hlp is the transfer function of the corresponding lowpass
% filter.  Thus, we can use function lpfilter to generate highpass
% filters.

if nargin == 4
   n = 1; % Default value of n.
end

% Generate highpass filter.
Hlp = LowpassFilter(type, M, N, D0, n);
H = 1 - Hlp;