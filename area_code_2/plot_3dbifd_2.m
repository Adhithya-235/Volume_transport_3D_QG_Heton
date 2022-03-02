clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

YV = 1;
ZV = 0;

%% CREATE FIGURE AND POPULATE

f = figure;
hold on
xlabel('$y$', 'interpreter', 'latex')
ylabel('$x$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')
    
%% FIX Z VALUE

Z = ZV(1);
    
%% CREATE z GRID
    
z = linspace(-sqrt(3), sqrt(3), 1000);
    
%% COMPUTE FIXED POINTS
    
xs = sqrt((3 - z.^2)*(1 + Z^2));
ys = -z*Z;
    
%% PLOT
    
plot3(ys, xs, z, 'r--', 'linewidth', 4)
plot3(ys, -xs, z, 'r--', 'linewidth', 4)

%% LOAD y-AXIS FIXED POINT DATA

load yaxisfpZ0.mat
xc = zeros(size(z2));

%% PLOTEM

plot3(YFT2, xc, z2, 'b-', 'linewidth', 4)
plot3(YFB2, xc, z2, 'b-', 'linewidth', 4)
plot3(YFT3, xc, z3, 'b-', 'linewidth', 4)
plot3(YFB3, xc, z3, 'r--', 'linewidth', 4)

%% REFLECT POINTS ABOUT ORIGIN

plot3(-YFT2, xc, -z2, 'b-', 'linewidth', 4)
plot3(-YFB2, xc, -z2, 'b-', 'linewidth', 4)
plot3(-YFT3, xc, -z3, 'b-', 'linewidth', 4);
plot3(-YFB3, xc, -z3, 'r--', 'linewidth', 4);

%% SLICE PLANES ON WHICH THE FIXED POINTS ARE EMBEDDED

s = 2;
xsls = [-s s s -s];                     xslc = [0 0 0 0];
ysls = [s s -s -s]*Z;                     yslc = [s s -s -s];
zsls = [-s -s s s];             zslc = [-s s s -s];

patch(ysls, xsls, zsls, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);
patch(yslc, xslc, zslc, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);

%% MARK BIFURCATION POINTS

fbif = [0 sqrt(3)];
plot3(-Z*sqrt(3), 0, sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(Z*sqrt(3), 0, -sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(fbif(1), 0, fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(-fbif(1), 0, -fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')

%% ELEMENTS OF DECORATION

sp = 2.5; ztop = 2;
xlim([-sp, sp])
ylim([-sp, sp])
zlim([-s, ztop])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid on 
box on 
view([135, 25])
daspect([1 1 0.4])
