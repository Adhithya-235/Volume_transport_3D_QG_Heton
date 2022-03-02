%========================================================================%
%   Test volume code.                                                    %
%========================================================================%
clear
close all
clc


%% PRELIMINARIES

h  = 1;
Z  = 5;
XE = 20;

%guess = [-0.318514899853444   3.183635888746892];
guess = [-6.634098680996581  17.757994120788322];

%% ITERATION VARIABLES

mit = 10000;
tol = 1e-3;
err = Inf;
mul = 0.5;
ite = 0;

%% INITIAL VOLUME COMPUTATION

[Vp, ~, ~] = calc_voltot(h, h, Z, XE, guess); 
h = mul*h;
ite = ite + 1;

%% LOOP UNTIL CONVERGENCE

while (err > tol) && (ite < mit)
    [Vn, Av, zv] = calc_voltot(h, h, Z, XE, guess); 
    err = abs(Vn-Vp)/abs(Vp);
    Vp = Vn;
    h  = mul*h;
    ite = ite + 1;
end
%% PLOT AREA VARIATION

figure(1)
plot(Av, zv, 'b-o', 'linewidth', 3, 'markersize', 3)
xlabel('Trapping area')
ylabel('z')
axis tight
axis square
set(gca, 'linewidth', 2, 'fontsize', 20)
grid on
box on