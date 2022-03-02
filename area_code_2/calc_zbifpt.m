function zbif = calc_zbifpt(y1, z1, zs)

%   Find the final saddle-node bifurcation point for Hetons with one vortex
%   placed at (y1, z1). Start from guess zs, usually
%   furnished using a graphical method. 

%% DEFINE FUNCTION

f = @(z) calc_cfpdist(y1, z1, z);

%% OPTIONS

options1 = optimoptions('fsolve', 'Display', 'none', ...
    'FunctionTolerance', eps, 'OptimalityTolerance', eps);

%% FIND ROOT using fzero

zbif = fsolve(f, zs, options1);

end