function bifpt = calc_zbifpt_2(y1, z1, guess)

%   Find the final saddle-node bifurcation point for Hetons with one vortex
%   placed at (y1, z1). Start from guess, usually
%   furnished using a graphical method. 

%% DEFINE FUNCTION

f = @(inpt) calc_zbifcn(inpt(1), inpt(2), y1, z1);

%% OPTIONS

options1 = optimoptions('fsolve', 'Display', 'off', ...
    'FunctionTolerance', eps, 'OptimalityTolerance', eps);

%% FIND ROOT using fsolve

bifpt = fsolve(f, guess, options1);

end