%=========================================================================%
%   Study streamfunction structure due to a single 3D heton in a          %
%   particular z = constant plane.                                        % 
%=========================================================================%

clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 1; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE

z = 0;
[xf,yf,zbif] = calc_snfixedp(y1, z1, z);

%% CREATE MESH FOR STREAMFUNCTION

xs  =  0;   ys = yf;
xe  =  5;   ye = xe;
hx  = 0.01;  hy = hx;
[dA, mx, my, MX, MY] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);

%% CALCULATE STREAMFUNCTION

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, MX, MY);

%% INITIALIZE FIGURE

f = figure;
hold on

%% DENSITY PLOT

pcolor(MX, MY, S)
colormap parula
shading flat

%% AXIS LABELS AND FONTSIZE

xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
title(sprintf('z = %1.4f, Z = %d', z, z1)); 
c1 = colorbar;
c1.Label.String = '$\Psi(x, y)$';
c1.Label.FontSize = 20;
c1.Label.Interpreter = 'latex';

%% AXIS LIMITS AND ASPECT RATIO

axis tight
axis square

%% ELEMENTS OF DECORATION

box on
set(gca, 'fontsize', 20, 'linewidth', 2)