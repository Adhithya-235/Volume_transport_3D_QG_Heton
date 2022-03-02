clear 
close all
clc

%% HETON POSITIONS

P1 = [0, 1, 1];
P2 = [0, -1, -1];

%% FIGURE INITIALIZATION

f = figure;
hold on
xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')

%% HETON AXIS

xa = zeros(1, 500);
ya = linspace(-1, 1, 500);

plot3(xa, ya, ya, '--', 'linewidth', 4, 'color', [0.4 0.4 0.4])

%% POINT VORTICES

plot3(P1(1), P1(2), P1(3), 'ko', 'linewidth', 3, 'markersize', 18, 'markerfacecolor', [0.4, 0.4, 0.4])
plot3(P2(1), P2(2), P2(3), 'ko', 'linewidth', 3, 'markersize', 18, 'markerfacecolor', [0.4, 0.4, 0.4])

%% SURFACE PATCHES

xp1 = [0 0 0 0];
yp1 = [-2 2 2 -2];
zp1 = [-2 -2 2 2];

xp2 = [-2 -2 2 2];
yp2 = [-2 2 2 -2];
zp2 = [0 0 0 0];

patch(xp1, yp1, zp1, 'w', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', 'k');
patch(xp2, yp2, zp2, 'w', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', 'k');

%% PLOT LINES

l = linspace(-2,2,500);
z = zeros(size(l));

plot3(z,l,z,'k-','linewidth', 5)
plot3(z,z,l,'k-','linewidth', 5)
plot3(l,z,z,'k-','linewidth', 5)

%% ELEMENTS OF DECORATION

xlim([-2, 2])
ylim([-2, 2])
zlim([-2, 2])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid off 
box on 
view([45, 25])
axis off