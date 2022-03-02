%=========================================================================%
%  Plot the volume of the trapping region against Z.                      %
%=========================================================================%

clear
close all
clc

%% FILE NUMBERS 

fnos = 1:3;

%% CREATE SOLUTION VECTORS

ZZ = [];
VT = [];

%% COLLECT DATA

for i = 1:length(fnos)
    
    %% FILE NAME
    
    fname = sprintf('../import_2/volm/volm_%d.mat', fnos(i)); 
    
    %% LOAD DATA INTO TEMPORARY STRUCTURE
    
    temp = load(fname); 
    
    %% COLLATE DATA
    
    ZZ = [ZZ, temp.Z];
    VT = [VT; temp.VV];
    
end


%% CALCULATE POSSIBLE SCALINGS

%S1 = ZZ.^3;
S2 = ZZ.^4;

%% PLOT DATA

f = figure;
hold on
plot(ZZ, VT', 'k-', 'linewidth', 5)
%plot(ZZ, 10*ones(size(ZZ)), '--','color', [0.2, 0.2, 0.2], 'linewidth', 4)
plot(ZZ, 5.5*S2, '--','color', [0, 0, 0], 'linewidth', 5)
xlabel('$Z$', 'interpreter', 'latex')
ylabel('$V_T$', 'interpreter', 'latex')
axis tight
%xlim([ZZ(1), 10])
ylim([1e1, 2e5])
axis square
grid off
box on
set(gca, 'fontsize', 40, 'linewidth', 5)
set(gca, 'xscale', 'log', 'yscale', 'log')
set(gca, 'xtick', [0.1 1 10], 'ytick', [1e1 1e3 1e5])

%% NEW AXES POSITIONING

p  = get(gca,'position');
np = [p(1)+0.02, p(2)+0.2, p(3)/1.5, p(4)/1.5];
axes('position',np);
hold on

%% LOAD NEW DATA

temp2 = load('zsn.mat');
Z2 = temp2.ZZ;
zs = temp2.ffbif;

%% PLOTTING z_sn

S2 = Z2.^(4/3);
plot(Z2, zs, 'k-', 'linewidth', 5)
plot(Z2, 1.5*S2, '--','color', [0, 0, 0], 'linewidth', 5)

%% ELEMENTS OF DECORATION

set(gca, 'box', 'on', 'linewidth', 5, 'fontsize', 30,...
    'plotboxaspectratio', [1 1.5 1], 'xscale', 'log', 'yscale', 'log',...
    'ytick',[2 10 50])
xlabel('$Z$', 'interpreter', 'latex')
ylabel('$z_{sn}$', 'interpreter', 'latex')
xlim([0.1, 10])
ylim([1, 50])