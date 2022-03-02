function[XDOT, YDOT, ZDOT, L, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
    zp, G, xp, yp)

%   Calculates the vector field (XDOT, YDOT, ZDOT) and streamfunction (S)
%   associated with the dynamics of a passive particle placed at (xp, yp,
%   zp) under the influence of two counter-rotating vortices placed at
%   (x1, y1, z1) and (x2, y2, z2). G is the strength of these vortices,
%   usually set to 4*pi. L is the magnitude of the vector field, useful
%   when making quiver plots.

%% CALCULATE HETON VELOCITIES

R_vort = (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2;
u = (-G*(y1-y2))/(4*pi*(R_vort^(3/2)));
v = (G*(x1-x2))/(4*pi*(R_vort^(3/2)));

%% VECTOR FIELD PRELIMINARIES

G1 = G/(4*pi);
DXP1 = xp - x1;
DXP2 = xp - x2;
DYP1 = yp - y1;
DYP2 = yp - y2;
DZP1 = zp - z1;
DZP2 = zp - z2;
RP1 = DXP1.^2 + DYP1.^2 + DZP1.^2;
RP2 = DXP2.^2 + DYP2.^2 + DZP2.^2;

%% CALCULATE VECTOR FIELD

XDOT = G1*(DYP1./(RP1.^(3/2)) - DYP2./(RP2.^(3/2))) - u;
YDOT = G1*(DXP2./(RP2.^(3/2)) - DXP1./(RP1.^(3/2))) - v;
ZDOT = zeros(size(XDOT));

%% CALCULATE STREAMFUNCTION

S = G1./(RP1.^(1/2)) - G1./(RP2.^(1/2)) + u*yp - v*xp;

%% CALCULATE VECTOR FIELD MAGNITUDE

L = (XDOT.^2 + YDOT.^2 + ZDOT.^2).^(1/2);

end