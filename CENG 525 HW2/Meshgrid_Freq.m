function [U, V] = Meshgrid_Freq(row, col)
% range of variables.
u = 0:(row-1);
v = 0:(col-1);

% indices in meshgrid
idx = find(u > row/2);
u(idx) = u(idx) - row;
idy = find(v > col/2);
v(idy) = v(idy) - col;

% Compute the meshgrid arrays
[V, U] = meshgrid(v, u);
