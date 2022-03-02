function [V, Av, zv] = calc_volhet(dz, h, Z, XE)

%   Calculates the trapping volume in the heteroclinic regime due to a
%   heton with vortices at +/-(0, 1, Z). The variable dz decides
%   discretization in z, while h decides it in x and y. XE is used to
%   define a rectangular boundary within which the trapping volume is
%   estimated to exist at each plane z. 

%% GENERATE z GRID

zv = 0:dz:sqrt(3)-dz; 

%% PREALLOCATE SOLUTION VECTOR

Av = zeros(size(zv));

%% SPECIFY HETON

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = Z; z2 = -z1;
G  = 1;

%% CALCULATE TRAPPING AREA IN EACH PLANE z

for i = 1:length(zv)
    
    %% SPECIFY z PLANE, y-POSITION OF SADDLES, CALCULATE BOUNDING S VALUE
    
    z = zv(i); 
    [~,yf,~] = calc_snfixedp(y1, z1, z);
    [~, ~, ~, ~, SM] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);
    
    %% CREATE MESH FOR STREAMFUNCTION, TOP 

    xs = 0;   ys = yf;
    xe = XE;  ye = xe;
    hx = h;   hy = h;
    [dA, mx, my, ~, ~] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);
    
    %% TOP AREA
    
    cond = @gt;
    TRAT = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
    SM, cond); 

    %% CREATE MESH FOR STREAMFUNCTION, BOTTOM

    xs = 0;   ys = -xe;
    xe = XE;  ye = yf;
    hx = h;   hy = h;
    [dA, mx, my, ~, ~] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);
    
    %% BOTTOM AREA
    
    cond = @lt;
    TRAB = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
    SM, cond); 

    %% TOTAL AREA
    
    Av(i) = TRAT + TRAB;
    
end

%% VOLUME TRAPPED IN THE HETEROCLINIC REGION

V = 2*sum(Av)*dz;

end