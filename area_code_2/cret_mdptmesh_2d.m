function [dA, mx, my, MX, MY] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy)

% Given a rectangular area defined by (xs, ys) and (xe, ye), bounding
% corners, and discretizations (hx, hy), this code finds the midpoint of
% each little box in the grid, and creates a mesh out of those. 

%% BOUNDING GRID GENERATION

x = xs:hx:xe;
y = ys:hy:ye;

%% MIDPOINT GRID GENERATION

mx = zeros(length(x) - 1,1);
my = zeros(length(y) - 1,1);

for i = 1:length(mx)
   mx(i) = 0.5*(x(i) + x(i+1));    
end

for i = 1:length(my)
   my(i) = 0.5*(y(i) + y(i+1));    
end

%% 2D MIDPOINT MESH

[MX, MY] = meshgrid(mx, my);

%% BOX AREA

dA = hx*hy;

end