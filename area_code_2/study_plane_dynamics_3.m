%=========================================================================%
%   Study passive particle dynamics due to a single 3D heton in a         %
%   particular z = constant plane.                                        % 
%=========================================================================%

clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 0; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE

z = 0;

%% CREATE MESH FOR VECTOR FIELD AND STREAMFUNCTION

xs = 4; ys = xs; zs = xs;
x_v = linspace(-xs,xs,500);               x_s = linspace(-xs,xs,100);
y_v = linspace(-ys,ys,500);               y_s = linspace(-ys,ys,100);
z_v = linspace(-zs,zs,500);               z_s = linspace(-zs,zs,100);
[XV,YV,ZV] = meshgrid(x_v, y_v, z_v);    [XS,YS,ZS] = meshgrid(x_s, y_s, z_s);

%% CALCULATE VECTOR FIELD AND STREAMFUNCTION OVER APPROPRIATE GRIDS

[XDOT, YDOT, ZDOT, L,~] = calc_streamfcn(x1, x2, y1, y2, z1, z2, ZV, G, ...
    XV, YV);

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, ZS, G, XS, YS);

%% CALCULATE FIXED POINTS 

%   The centers are prone to vanishing above a certain z. Do not panic. 

[xf,yf,zbif] = calc_snfixedp(y1, z1, z);            % Saddle-node
ycf_top      = calc_ctfixedp(y1, z1, z, 1.1);         % Top center
ycf_bot      = calc_ctfixedp(y1, z1, z, -1.1);        % Bottom center

%% CALCULATE STREAMFUNCTION VALUES OVER THE TRAPPING CONTOURS

% The trapping contours are heteroclinic connections between unstable fixed
% points. 

[~,~, ~, ~, SM] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);

%% CALCULATE STREAMFUNCTION VALUES ON OTHER FIXED POINTS

[~,~, ~, ~, ST] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, ycf_top);
[~,~, ~, ~, SB] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, ycf_bot);

%% INITIALIZE FIGURE

f = figure;
hold on

%% SPECIFY VARIOUS CONTOUR LEVELS

v1 = [SM, SM];

%% PLOT STREAMSLICE

ss = streamslice(XV, YV, ZV, XDOT, YDOT, ZDOT, [], [], z, 0.75, 'cubic');
set(ss, 'linewidth', 3, 'color', [0.5, 0.5, 0.5], 'linestyle', '-')

%% PLOT VARIOUS CONTOURS (GENERAL, TRAPPING, CENTER-ASSOCIATED)

cs = contourslice(XS, YS, ZS, S, [], [], z, v1);
set(cs, 'linewidth', 5, 'edgecolor', 'k')

%% PLOT FIXED POINTS

plot3(0, 1, z, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
plot3(0, -1, z, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
plot3(xf, yf, z, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)
plot3(-xf,yf, z, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)

%% TITLE AND AXIS LABELS

xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
%title(sprintf('Phase portrait, z = %1.4f, Z = %d', z, z1)); 

%% AXIS LIMITS AND ASPECT RATIO

xlim([x_s(1) x_s(end)])
ylim([y_s(1) y_s(end)])
axis square

%% ELEMENTS OF DECORATION

grid off
box on
set(gca, 'fontsize', 40, 'linewidth', 5)