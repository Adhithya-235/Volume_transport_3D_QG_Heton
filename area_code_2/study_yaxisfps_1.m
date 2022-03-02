%=========================================================================%
%  Plot approximate locations for the fixed points on the y-axis, x = 0 for
%  various values of z, with y1 = 1, z1 = variable.
%=========================================================================%

clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

Y = 1;
Z = 100;

%% FIX y AND z VALUES

y = linspace(-1000, 1000, 300);
%z = linspace(0, 2.5, 15);
z =  20;

%% CREATE LHS FUNCTION

f = @(y, z) (y - Y)./(((y - Y).^2 + (z - Z).^2 ).^(3/2)) - ...
    (y + Y)./(((y + Y).^2 + (z + Z).^2 ).^(3/2));

%% CREATE SOLUTION ARRAYS

lhs = zeros(length(y), length(z));

%% CALCULATE LHS AND RHS

for i = 1:length(z)
    lhs(:, i) = f(y, z(i));
end

rhs = (-(Y/4)/((Y^2 + Z^2)^(3/2)))*ones(size(y));

%% PLOT CURVES

f = figure;
hold on
plot(y, rhs, 'b-', 'linewidth', 2)
plot(y, lhs, 'k-', 'linewidth', 2.5)
xlabel('$y$', 'interpreter', 'latex')
ylabel('$f(y,z)$', 'interpreter', 'latex')
axis tight
%ylim([-2, 2])
set(gca, 'fontsize', 20, 'linewidth', 2)
grid on
box on 

