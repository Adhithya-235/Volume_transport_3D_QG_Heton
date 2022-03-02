%=========================================================================%
%  Plot approximate locations for the fixed points on the y-axis, x = 0 for
%  various values of z, with y1 = 1, z1 = variable.
%=========================================================================%

clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

Y = 1;
Z = 10;

%% CREATE yz MESH

s = 50;
y = linspace(-s, s, 0.5*4096);
z = linspace(-s, s, 0.5*4096);
[ym, zm] = meshgrid(y, z);

%% CALCULATE RHS

rhs = (-(Y/4)/((Y^2 + Z^2)^(3/2)));

%% CALCULATE LHS

lhs = (ym - Y)./(((ym - Y).^2 + (zm - Z).^2 ).^(3/2)) - ...
    (ym + Y)./(((ym + Y).^2 + (zm + Z).^2 ).^(3/2));

%% INITIALIZE FIGURE

f = figure;
hold on

%% SPECIFY CONTOUR LEVEL (IE RHS)

v0 = [rhs, rhs];

%% DRAW pcolor PLOT

%pcolor(ym, zm, lhs)
%colormap turbo
%shading interp
%c1 = colorbar;

%% SOME BOUNDING LINES

xline(-1, 'm--', 'linewidth', 2.5)
xline(1, 'm--', 'linewidth', 2.5)
yline(-sqrt(3), 'b--', 'linewidth', 2.5)
yline(sqrt(3), 'b--', 'linewidth', 2.5)

%% DRAW FIXED POINTS CONTOUR

[C, h] = contour(y, z, lhs, v0, 'k', 'linewidth', 4, 'showtext', 'off');

%% FIND MAXIMUM DISTANCE POINT

[mxv, mxi] = max(C(1, 2:end).^2 + C(2, 2:end).^2);
pt = C(:, mxi);
slp = pt(2)/pt(1);

%% DRAW LINE OF REFLECTION

plot(y, slp*y, 'b', 'linewidth', 2)

%% LABELS AND FONTSIZE

xlabel('$y$', 'interpreter', 'latex')
ylabel('$z$', 'interpreter', 'latex')
c1.Label.String = '$f(y, z)$';
c1.Label.FontSize = 24;
c1.Label.Interpreter = 'latex';
caxis([-2, 2])

%% ELEMENTS OF DECORATION

axis tight
ylim([-s, s])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
box on 
grid on 

%% FIND BIFURCATION POINT GRAPHICALLY

[zg, maxind] = max(C(2, 2:end));
yg = C(1, maxind);

%% FIND BIFURCATION POINT NUMERICALLY

zbif = calc_zbifpt(Y, Z, zg);
guess = [yg, zg]; 
bifpt = calc_zbifpt_2(Y, Z, guess);
