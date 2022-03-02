clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

YV = 1;
ZV = 0;

%% CREATE FIGURE AND POPULATE

f = figure;
hold on
xlabel('$y$', 'interpreter', 'latex')
ylabel('$x$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')
    
%% FIX Z VALUE

Z = ZV(1);
    
%% CREATE z GRID
    
z = linspace(-sqrt(3), sqrt(3), 1000);
    
%% COMPUTE FIXED POINTS
    
xs = sqrt((3 - z.^2)*(1 + Z^2));
ys = -z*Z;
    
%% PLOT
    
plot3(ys, xs, z, 'r--', 'linewidth', 4)
plot3(ys, -xs, z, 'r--', 'linewidth', 4)

%% LOAD y-AXIS FIXED POINT DATA

load yaxisfpZ0.mat
xc = zeros(size(z2));

%% PLOTEM

plot3(YFT2, xc, z2, 'b-', 'linewidth', 4)
plot3(YFB2, xc, z2, 'b-', 'linewidth', 4)
plot3(YFT3, xc, z3, 'b-', 'linewidth', 4)
plot3(YFB3, xc, z3, 'r--', 'linewidth', 4)

%% REFLECT POINTS ABOUT ORIGIN

plot3(-YFT2, xc, -z2, 'b-', 'linewidth', 4)
plot3(-YFB2, xc, -z2, 'b-', 'linewidth', 4)
plot3(-YFT3, xc, -z3, 'b-', 'linewidth', 4);
plot3(-YFB3, xc, -z3, 'r--', 'linewidth', 4);

%% SLICE PLANES ON WHICH THE FIXED POINTS ARE EMBEDDED

s = 2.5; zz = sqrt(3)+0.25;
xsls = [-s s s -s];                     xslc = [0 0 0 0];
ysls = [s s -s -s]*Z;                     yslc = [s s -s -s];
zsls = [-zz -zz zz zz];             zslc = [-zz zz zz -zz];

patch(ysls, xsls, zsls, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);
patch(yslc, xslc, zslc, 'c', 'FaceAlpha', 0.3, 'Linewidth', 5, 'EdgeColor', [0.6, 0.6, 0.6]);

%% MARK BIFURCATION POINTS

fbif = [0 sqrt(3)];
plot3(-Z*sqrt(3), 0, sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(Z*sqrt(3), 0, -sqrt(3), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(fbif(1), 0, fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')
plot3(-fbif(1), 0, -fbif(2), 'ko', 'markersize', 18, 'markerfacecolor', 'k')

%% ELEMENTS OF DECORATION

sp = 2.5; ztop = sqrt(3);
xlim([-sp, sp])
ylim([-sp, sp])
zlim([-ztop-0.25, ztop+0.25])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid on 
box on 
view([135, 25])
daspect([1 1 0.25])

%% HETON PARAMETERS IN COMOVING FRAME

x1 = 0; y1 =  1;
x2 = 0; y2 = -y1;
z1 = 0; z2 =  -z1;
G = 1;

%% SN BIFURCATION HEIGHT

zbif = sqrt(3);

%% GENERATE MESH

s = 2.5;
x_s = linspace(-s,s,1000);
y_s = linspace(-s,s,1000);
z_s = linspace(-zbif, 0, 3);
[YS,XS,ZS] = meshgrid(y_s,x_s,z_s);

%% CALCULATE STREAMFUNCTION

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, ZS, G, XS, YS);

%% CALCULATE TRAPPING CONTOURS/FIXED PTS

xf = zeros(size(z_s));
yf = zeros(size(z_s));
st = zeros(size(z_s));

for i = 1:length(z_s)
    if z_s(i) < -sqrt(3)
        yf(i) = calc_ctfixedp(y1, z1, z_s(i), 1.1); % Top saddle
    elseif z_s(i) >= -sqrt(3)
        [xf(i),yf(i),~] = calc_snfixedp(y1, z1, z_s(i)); % Side saddles
    end
    [~,~, ~, ~, st(i)] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
        z_s(i), G, 0, yf(i));
end

%% PLOT TRAPPING CONTOURS 

csl = gobjects(2, length(z_s));
for i = 1:length(z_s)
   lvls     = [st(i) st(i)];
   csl(:,i) = contourslice(YS,XS,ZS,S,[],[],z_s(i),lvls);
   set(csl(:,i),'linewidth',5,'edgecolor','k')
   if z_s(i) < -sqrt(3)
       plot3(yf(i), 0, z_s(i), 'ro', 'markersize', 18, 'markerfacecolor', 'r')
   elseif z_s(i) >= -sqrt(3)
       plot3(yf(i), xf(i), z_s(i), 'ro', 'markersize', 18, 'markerfacecolor', 'r')
       plot3(yf(i), -xf(i), z_s(i), 'ro', 'markersize', 18, 'markerfacecolor', 'r')
   end
end

%% ELEMENTS OF DECORATION

% xlabel('$y$', 'interpreter', 'latex')
% ylabel('$x$', 'interpreter', 'latex')
% zlabel('$z$', 'interpreter', 'latex')
% xlim([-s,s])
% ylim([-s,s])
% zlim([-zbif-0.25, 0+0.25])
% view([135 25])
% daspect([2 2 0.15])
% grid on
% box on
% set(gca, 'linewidth', 5, 'fontsize',40)

%% GET PATCH COORDINATES

PAT = zeros(3,4,length(z_s));
xs = x_s(1); xe = x_s(end);
ys = y_s(1); ye = y_s(end); 

for i = 1:length(z_s)
   PAT(1, :, i) = [xs, xe, xe, xs];
   PAT(2, :, i) = [ys, ys, ye, ye];
   PAT(3, :, i) = z_s(i)*ones(1,4);
end

%% DRAW PATCHES

for i = 1:length(z_s)
    patch(PAT(1,:,i), PAT(2,:,i), PAT(3,:,i), 'y', 'FaceAlpha', 0.3, 'Linewidth',...
        5, 'EdgeColor', [0, 0, 0]);
end