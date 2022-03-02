%=========================================================================%
%   Study eigenvalues of the Jacobian as a function of z.                 %
%=========================================================================%
clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 1; z2 = -z1;
G  = 1;

%% GUESS zb2 LOCATION (FROM study_yaxisfps_2.m)

guess = [-0.318514899853444   3.183635888746892];

%% REFINE GUESS

bifpt = calc_zbifpt_2(y1, z1, guess);

%% GUESS FOR ycf_top

if z1 < 10
    ycg = 1.1;
else
    ycg = z1;
end

%% GET z-GRID

z = linspace(1.2, bifpt(2), 500)';

%% SOLUTION VECTORS

snl = zeros(length(z),2);
snr = zeros(length(z),2);
ctt = zeros(length(z),2);
ctb = zeros(length(z),2);

%% COMPUTE EIGENVALUES

swtch = 0;
for i=1:length(z)
    if z(i)<sqrt(3)
        [xf,yf,~] = calc_snfixedp(y1, z1, z(i));
        snl(i,:) = eig(calc_jacobtl(-xf, yf, z(i), y1, z1, G));
        snr(i,:) = eig(calc_jacobtl(xf, yf, z(i), y1, z1, G));
        ycf_top = calc_ctfixedp(y1, z1, z(i), ycg);
        ctt(i,:) = eig(calc_jacobtl(0, ycf_top, z(i), y1, z1, G));
        ycf_bot = calc_ctfixedp(y1, z1, z(i), -ycg);
        ctb(i,:) = eig(calc_jacobtl(0, ycf_bot, z(i), y1, z1, G));
    elseif z(i)>=sqrt(3)
        if swtch == 0
           ycf_top = calc_ctfixedp(y1, z1, z(i), ycg); 
           ctt(i,:) = eig(calc_jacobtl(0, ycf_top, z(i), y1, z1, G));
           yctold = ycf_top;
           ycf_bot = calc_ctfixedp(y1, z1, z(i), -ycg); 
           ctb(i,:) = eig(calc_jacobtl(0, ycf_bot, z(i), y1, z1, G));
           ycbold = ycf_bot;
           swtch = 1;
       else 
           ycf_top = calc_ctfixedp(y1, z1, z(i), yctold); 
           ctt(i,:) = eig(calc_jacobtl(0, ycf_top, z(i), y1, z1, G));
           yctold = ycf_top;
           ycf_bot = calc_ctfixedp(y1, z1, z(i), ycbold); 
           ctb(i,:) = eig(calc_jacobtl(0, ycf_bot, z(i), y1, z1, G));
           ycbold = ycf_bot;
       end
    end
end

%% CUT OFF ZEROES

snl = snl(1:134, :);
snr = snr(1:134, :);
zs  = z(1:134);

%% INITIALIZE FIGURE

figure(1)
hold on
xlabel('$Re(\lambda)$', 'interpreter', 'latex')
ylabel('$Im(\lambda)$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')

%% PLOT HETEROCLINIC REGION UNSTABLE EIGENVALUES

plot3(real(snr(:,1)),imag(snr(:,1)),zs,'r.','markersize',18)
plot3(real(snr(:,2)),imag(snr(:,2)),zs,'r.','markersize',18)
plot3(real(snl(:,1)),imag(snl(:,1)),zs,'r.','markersize',18)
plot3(real(snl(:,2)),imag(snl(:,2)),zs,'r.','markersize',18)

%% PLOT HET-STABLE AND HOM-S/U EIGENVALUES

plot3(real(ctt(:,1)),imag(ctt(:,1)),z,'b.','markersize',18)
plot3(real(ctt(:,2)),imag(ctt(:,2)),z,'b.','markersize',18)
plot3(real(ctb(1:134,1)),imag(ctb(1:134,1)),zs,'b.','markersize',18)
plot3(real(ctb(1:134,2)),imag(ctb(1:134,2)),zs,'b.','markersize',18)
plot3(real(ctb(134:end,1)),imag(ctb(134:end,1)),z(134:end),'m.','markersize',18)
plot3(real(ctb(134:end,2)),imag(ctb(134:end,2)),z(134:end),'m.','markersize',18)

%% ELEMENTS OF DECORATION

axis tight
xlim([-0.05,0.05])
ylim([-0.05,0.05])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid on 
box on 
view([135, 25])
