function H = notchFilter(type, M, N, D0, x, y, n)
% 'ideal'     Ideal highpass filter with positive cutoff frequency D0
% 'btw'       Butterworth highpass filter of order n, and positive cutoff D0
% 'gaussian'  Gaussian highpass filter with cutoff (standard deviation) D0
% size (M-by-N). centered at Column X, Row Y in an unshifted Fourier spectrum.

if nargin == 6
   n = 1; % Default
end

H = highpassFilter(type, M, N, D0, n);
% circularly shifts first dimension values down by y-1 
% second dimension left by x-1.
H = circshift(H, [y-1 x-1]);
