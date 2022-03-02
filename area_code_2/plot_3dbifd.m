clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

YV = 1;
ZV = 0;

%% CREATE FIGURE AND POPULATE

f = figure;
hold on
xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')
    
%% FIX Z VALUE

Z = ZV(1);
    
%% CREATE z GRID
    
z = linspace(-sqrt(3), sqrt(3), 1000);
    
%% COMPUTE FIXED POINTS
    
xs = sqrt((3 - z.^2)*(1 + Z^2));
ys = -z*Z;
    
%% PLOT
    
plot3(xs, ys, z, 'r--', 'linewidth', 4)
plot3(-xs, ys, z, 'r--', 'linewidth', 4)

%% LOAD y-AXIS FIXED POINT DATA

load yaxisfpZ0.mat
xc = zeros(size(z2));

%% PLOTEM

plot3(xc, YFT2, z2, 'b-', 'linewidth', 4)
plot3(xc, YFB2, z2, 'b-', 'linewidth', 4)
plot3(xc, YFT3, z3, 'b-', 'linewidth', 4)
plot3(xc, YFB3, z3, 'r--', 'linewidth', 4)

%% REFLECT POINTS ABOUT ORIGIN

plot3(xc, -YFT2, -z2, 'b-', 'linewidth', 4)
plot3(xc, -YFB2, -z2, 'b-', 'linewidth', 4)
plot3(xc, -YFT3, -z3, 'b-', 'linewidth', 4);
plot3(xc, -YFB3, -z3, 'r--', 'linewidth', 4);

%% SLICE PLANES ON WHICH THE FIXED POINTS ARE EMBEDDED

s = 2;
xsls = [-s s s -s];             xslc = [0 0 0 0];
ysls = [s s -s -s]*Z;           yslc = [s s -s -s];
zsls = [-s -s s s];             zslc = [-s s s -s];

patch(xsls, ysls, zsls, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);
patch(xslc, yslc, zslc, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);

%% MARK BIFURCATION POINTS

fbif = [0  sqrt(3)];
plot3(0, -Z*sqrt(3), sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(0, Z*sqrt(3), -sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(0, fbif(1), fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(0, -fbif(1), -fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')

%% ELEMENTS OF DECORATION

sp = 2.5;
xlim([-sp, sp])
ylim([-sp, sp])
zlim([-s, s])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid on 
box on 
view([135, 25])

