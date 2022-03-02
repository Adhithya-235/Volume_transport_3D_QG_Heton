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

z = 1.8;

%% CREATE MESH FOR VECTOR FIELD AND STREAMFUNCTION

xs  = 5;   ys = xs;
x_s = linspace(-xs,xs,256);
y_s = linspace(-ys,ys,256);
[XS,YS] = meshgrid(x_s, y_s);

%% CALCULATE STREAMFUNCTION

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, XS, YS);

%% INITIALIZE FIGURE

f = figure;
hold on

%% DENSITY PLOT

pcolor(XS, YS, S)
colormap turbo
shading flat

%% AXIS LABELS AND FONTSIZE

xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
title(sprintf('z = %1.4f, Z = %d', z, z1)); 
c1 = colorbar;
c1.Label.String = '$\Psi(x, y)$';
c1.Label.FontSize = 20;
c1.Label.Interpreter = 'latex';
%caxis([-2, 2])

%% AXIS LIMITS AND ASPECT RATIO

axis tight
axis square

%% ELEMENTS OF DECORATION

box on
set(gca, 'fontsize', 20, 'linewidth', 2)

