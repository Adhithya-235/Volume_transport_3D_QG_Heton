function ycf = calc_ctfixedp(y1, z1, z, y0)

% Calculate the position (0, ycf) of stable (center) fixed points at
% a given plane z, for hetons with vortices at (+/- y1, +/- z1). This is 
% done numerically, starting with initial guess y0.

%% RENAME FOR CONVENIENCE

Y = y1;
Z = z1; 

%% CREATE FUNCTION WHOSE ROOTS ARE TO BE FOUND

f = @(y) ((y-Y)./((y-Y).^2 + (z-Z).^2).^(3/2))...
    - ((y+Y)./((y+Y).^2 + (z+Z).^2).^(3/2))...
    + (Y./((4.*(Y^2 + Z^2).^(3/2))));

%% FIND ROOTS USING fzero

options1 = optimoptions('fsolve', 'Display', 'none', ...
    'FunctionTolerance', eps, 'OptimalityTolerance', eps);
ycf = fsolve(f, y0, options1);

end