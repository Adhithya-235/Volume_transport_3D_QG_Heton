%=========================================================================%
%   Get an approximate idea of how the final bifurcation point -- the SN  %
%   and center -- varies with Z. Plot this point against Z.               %
%=========================================================================%

clear
close all
clc

%% FILE NUMBERS 

fnos = 1:13;

%% CREATE SOLUTION VECTORS

ZZ = [];
ffbif = [];

%% COLLECT DATA

for i = 1:length(fnos)
    
    %% FILE NAME
    
    fname = sprintf('../import_2/sfbif/sfbif_%d.mat', fnos(i)); 
    
    %% LOAD DATA INTO TEMPORARY STRUCTURE
    
    temp = load(fname); 
    
    %% COLLATE DATA
    
    ZZ = [ZZ, temp.Z];
    ffbif = [ffbif, temp.fbif];
    
end

%% REFINE FINAL BIFURCATION POINTS

% zbif = zeros(size(ffbif));
% 
% for i = 1:length(ffbif)
%    zbif(i) = calc_zbifpt(1, ZZ(i), ffbif(i)); 
% end

%% CALCULATE POSSIBLE SCALINGS

S1 = sqrt(1 + ZZ.^2);
S2 = ZZ.^(4/3);

%% PLOT DATA

f = figure;
hold on
plot(ZZ, ffbif, 'k-', 'linewidth', 5)
plot(ZZ, 1.5*S2, '--','color', [0, 0, 0], 'linewidth', 5)
%plot(ZZ, S2, 'r-', 'linewidth', 3)
xlabel('$Z$', 'interpreter', 'latex')
ylabel('$z_{sn}$', 'interpreter', 'latex')
%legend('|z_b|', '3^{0.5}', '3^{0.5}Z^{1.348}', 'location', 'northwest')
axis tight
xlim([0.1, 10])
ylim([1, 50])
axis square
grid off
box on
set(gca, 'fontsize', 40, 'linewidth', 5)
set(gca, 'xscale', 'log', 'yscale', 'log')
