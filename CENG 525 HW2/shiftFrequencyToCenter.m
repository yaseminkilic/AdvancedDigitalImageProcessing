% Shift zero-frequency component to center of spectrum
function x = shiftFrequencyToCenter(x,dim)

if nargin <= 1
    x = circshift(x,floor(size(x)/2));
else
    if (~isscalar(dim)) || floor(dim) ~= dim || dim < 1
        error(message(' '))
    end
    x = circshift(x,floor(size(x,dim)/2),dim);
end
