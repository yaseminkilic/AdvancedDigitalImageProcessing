function H = LowpassFilter(type, row, col, positiveCutoffFreq, n) 
% 'idealpass'       Ideal lowpass filter with cutoff frequency D0
% 'butterworth'         Butterworth lowpass filter of order n, and cutoff D0
% 'gaussian'    Gaussian lowpass filter with cutoff (standard deviation)

% Set up the meshgrid arrays needed (computed the required distances)
[U, V] = Meshgrid_Freq(row, col);

% Compute the distances D(U, V).
D = sqrt(U.^2 + V.^2);

switch type
    case 'idealpass'
        H = double(D <= positiveCutoffFreq);
    case 'butterworth'
        if nargin == 4
            n = 1;
        end
            H = 1./(1 + (D./positiveCutoffFreq).^(2*n));
    case 'gaussian'
        H = exp(-(D.^2)./(2*(positiveCutoffFreq^2)));
    otherwise
        error('Unknown filter type.')
end
end
