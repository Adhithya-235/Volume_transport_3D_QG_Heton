%=========================================================================%
%   Get an approximate idea of how the final bifurcation point -- the SN  %
%   and center -- varies with Z.                                          %
%=========================================================================%

clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

Y = 1;
Z = linspace(5, 10, 50);
%Z = 0;

%% CREATE SOLUTION ARRAYS

guess = zeros(length(Z), 2);

%% CREATE yz MESH

s = 48;
y = linspace(-s, s, 2048);
z = linspace(-s, s, 2048);
[ym, zm] = meshgrid(y, z);

for i = 1:length(Z)
    
    %% CALCULATE RHS

    rhs = (-(Y/4)/((Y^2 + Z(i)^2)^(3/2)));

    %% CALCULATE LHS

    lhs = (ym - Y)./(((ym - Y).^2 + (zm - Z(i)).^2 ).^(3/2)) - ...
        (ym + Y)./(((ym + Y).^2 + (zm + Z(i)).^2 ).^(3/2));

    %% SPECIFY CONTOUR LEVEL (IE RHS)

    v0 = [rhs, rhs];

    %% GET CONTOUR MATRIX

    C = contourc(y, z, lhs, v0);

    %% GET FINAL BIFURCATION POINT(s)

    [guess(i, 2), maxind] = max(C(2, 2:end));
    guess(i, 1) = C(1, maxind);
end

%% SAVE VARIABLES

save guess_3.mat Z guess;