function [xf,yf,zbif] = calc_snfixedp(y1, z1, z)

% Calculate the position (xf, yf) of unstable (saddle-node) fixed points at
% a given plane z, for hetons with vortices at (+/- y1, +/- z1). This can
% be done analytically. 

%% SET PARAMETERS

Y = y1;
Z = z1;

%% FIXED POINTS

xf = sqrt((3 - (z/Y).^2).*(Z^2 + Y^2));
yf = -(Z/Y)*z;

%% z-VALUE WHERE FIXED POINTS VANISH

zbif = Y*sqrt(3);

end