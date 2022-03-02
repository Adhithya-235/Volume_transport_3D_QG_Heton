function BF = calc_zbifcn(y, z, y1, z1)

%   Calculate the function whose root will give us the center-saddle
%   bifurcation point. 

%% CONVENIENCE VARIABLES

Y = y1;
Z = z1;

%% FIXED PARAMETERS

x = 0; % Interested in y-axis fixed points. 
G = 1; % Strength has no effect on fixed point structure. 

%% COMPUTE FUNCTION

BF(1) = ((y-Y)./((y-Y).^2 + (z-Z).^2).^(3/2))...
    - ((y+Y)./((y+Y).^2 + (z+Z).^2).^(3/2))...
    + (Y./((4.*(Y^2 + Z^2).^(3/2))));

BF(2) = det(calc_jacobtl(x, y, z, y1, z1, G));

end