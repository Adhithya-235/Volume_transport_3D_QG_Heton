%=========================================================================%
%   Compute the value of the trapping streamline psi_u at zb2.                   %
%=========================================================================%
clear
close all
clc

%% FILE NUMBERS

fnums = 1:3;

%% SOLUTION VECTORS

ZZ = [];
gg = [];

%% COLLECT DATA

for i = 1:length(fnums)
    
    %% FILE NAME
    
    fname = sprintf('../import_2/guess/guess_%d.mat', fnums(i));  
    
    %% LOAD DATA INTO TEMPORARY STRUCTURE
    
    temp = load(fname); 
    
    %% COLLATE DATA
    
    ZZ = [ZZ, temp.Z];
    gg = [gg; temp.guess];
    
end
ZZ = ZZ';

%% HETON POSITION AND STRENGTH

x1 = 0;  x2 = -x1;
y1 = 1;  y2 = -y1;
z1 = ZZ; z2 = -ZZ;
G  = 1;

%% REFINE GUESSES

bifpts = zeros(size(gg));
for i = 1:length(ZZ)
    bifpts(i,:) = calc_zbifpt_2(y1, z1(i), gg(i,:));
end

%% COMPUTE psiu(zb2)

psiu = zeros(size(ZZ));
for i = 1:length(ZZ)
    [~,~,~,~,psiu(i)] = calc_streamfcn(x1, x2, y1, y2, z1(i), z2(i),...
               bifpts(i,2), G, 0, bifpts(i,1));
end

%% PLOT psiu

figure(1)
hold on
plot(z1,psiu,'b-','linewidth',5)
plot(z1,0.02*z1.^(-1.6),'--','linewidth',5,'color',[0.5,0.5,0.5])
plot(z1,0.02*z1.^(0.95),'--','linewidth',5,'color',[0.5,0.5,0.5])
xlabel('$Z$','interpreter','latex')
ylabel('$\psi_u\left(z_{b_2}\right)$','interpreter','latex')
%axis tight
ylim([0.0008, 0.02])
axis square
box on
grid off
set(gca, 'fontsize', 40, 'linewidth', 5,'xscale','log','yscale','log')
yticks([0.001,0.01]);

%% COMPUTE STREAMFUNCTION COMPONENTS

psiv = zeros(size(ZZ));
psid = zeros(size(ZZ));
for i = 1:length(ZZ)
    [psiv(i),psid(i)] = calc_strmfcn_comps(x1, x2, y1, y2, z1(i), z2(i),...
               bifpts(i,2), G, 0, bifpts(i,1));
end

%% PLOT psiv, psid

figure(2)
hold on
plot(z1,psiv,'b-','linewidth',5)
plot(z1,psid,'r-','linewidth',5)
xlabel('$Z$','interpreter','latex')
ylabel('$\psi\left(z_{b_2}\right)$-components',...
    'interpreter','latex')
%axis tight
ylim([0.0001, 0.02])
axis square
box on
grid off
set(gca, 'fontsize', 40, 'linewidth', 5,'xscale','log','yscale','log')
yticks([0.0001,0.001,0.01]);

%% FUNCTIONS USED

function [psiv, psid] = calc_strmfcn_comps(x1, x2, y1, y2, z1, z2,...
    zp, G, xp, yp)

%% CALCULATE HETON VELOCITIES

R_vort = (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2;
u = (-G*(y1-y2))/(4*pi*(R_vort^(3/2)));
v = (G*(x1-x2))/(4*pi*(R_vort^(3/2)));

%% VECTOR FIELD PRELIMINARIES

G1 = G/(4*pi);
DXP1 = xp - x1;
DXP2 = xp - x2;
DYP1 = yp - y1;
DYP2 = yp - y2;
DZP1 = zp - z1;
DZP2 = zp - z2;
RP1 = DXP1.^2 + DYP1.^2 + DZP1.^2;
RP2 = DXP2.^2 + DYP2.^2 + DZP2.^2;

%% CALCULATE STREAMFUNCTION COMPONENTS

psiv = G1./(RP1.^(1/2)) - G1./(RP2.^(1/2)); 
psid = u*yp - v*xp;

end