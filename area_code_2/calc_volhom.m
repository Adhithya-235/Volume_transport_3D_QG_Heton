function [V, Av, zv] = calc_volhom(dz, h, Z, XE, guess)

%   Calculates the trapping volume in the homoclinic regime due to a
%   heton with vortices at +/-(0, 1, Z). The variable dz decides
%   discretization in z, while h decides it in x and y. XE is used to
%   define a rectangular boundary within which the trapping volume is
%   estimated to exist at each plane z. Finally, guess provides an initial 
%   point for the solver to determine the bifurcation point that bounds the
%   trapping region vertically. 

%% FIND BIFURCATION POINT

bifpt = calc_zbifpt_2(1, Z, guess);

%% GENERATE z GRID

zv = sqrt(3):dz:bifpt(2); 

%% PREALLOCATE SOLUTION VECTOR

Av = zeros(size(zv));

%% SPECIFY HETON

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = Z; z2 = -z1;
G  = 1;

%% CALCULATE TRAPPING AREA AT PLANE z

for i = 1:length(zv)
    
    %% SPECIFY z PLANE, y-POSITION OF SADDLES, CALCULATE BOUNDING S VALUE

    z = zv(i); 
    yf = calc_ctfixedp(y1, z1, z, -2*z1);
    [~, ~, ~, ~, SB] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);

    %% CREATE MESH FOR STREAMFUNCTION

    xs = 0;   ys = yf;
    xe = XE;  ye = xe;
    hx = h;   hy = h;
    [dA, mx, my, ~, ~] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);
    
    %% COMPUTE AREA

    cond = @gt;
    Av(i) = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
        SB, cond); 

end

%% VOLUME TRAPPED IN THE HOMOCLINIC REGION

V = 2*sum(Av)*dz;

end