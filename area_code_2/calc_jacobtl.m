function J = calc_jacobtl(x, y, z, y1, z1, G)

%   Calculate the Jacobian matrix of the vector field due to a heton placed
%   symmetrically about the origin at +/-(0, y1, z1) with vortices of
%   strength -/+ G at the point (x, y, z). 

%% PRELIMINARY CALCULATIONS 

G1 = G/4*pi; 
Rp = x.^2 + (y + y1).^2 + (z + z1).^2;
Rm = x.^2 + (y - y1).^2 + (z - z1).^2;

%% JACOBIAN ELEMENTS

J11 = G1*(3*x.*(y+y1)./(Rp.^(5/2)) - 3*x.*(y-y1)./(Rm.^(5/2)));

J12 = G1*(1./(Rm.^(3/2)) - 1./(Rp.^(3/2)) + 3*(y+y1).*(y+y1)./(Rp.^(5/2))...
    - 3*(y-y1).*(y-y1)./(Rm.^(5/2)));

J21 = G1*(1./(Rp.^(3/2)) - 1./(Rm.^(3/2)) + 3*x.*x./(Rm.^(5/2))...
    - 3*x.*x./(Rp.^(5/2)));

J22 = G1*(3*x.*(y-y1)./(Rm.^(5/2)) - 3*x.*(y+y1)./(Rp.^(5/2)));

%% FORM JACOBIAN

J = [J11 J12; J21 J22];

end