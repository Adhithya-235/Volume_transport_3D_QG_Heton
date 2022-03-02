function [V, Av, zv] = calc_voltot(dz, h, Z, XE, guess)

%   Calculates the trapping volume due to a heton with vortices at 
%   +/-(0, 1, Z). 

%% CALCULATE HOMOCLINIC AND HETEROCLINIC VOLUMES

[V1, Av1, zv1] = calc_volhet(dz, h, Z, XE);
[V2, Av2, zv2] = calc_volhom(dz, h, Z, XE, guess);

%% COLLATE DATA

V  = V1 + V2;
Av = [Av1, Av2]';
zv = [zv1, zv2]';

end