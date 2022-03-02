%=========================================================================%
%    Contour slices for the Z = 0 case.                                   %  
%=========================================================================%
clear 
close all
clc

%% HETON PARAMETERS IN COMOVING FRAME

x1 = 0; y1 =  1;
x2 = 0; y2 = -y1;
z1 = 10; z2 =  -z1;
G = 1;

%% SN BIFURCATION HEIGHT

zbif = 42.9;

%% GENERATE MESH

s = 60;
x_s = linspace(-s,s,1000);
y_s = linspace(-s,s,1000);
z_s = linspace(-zbif, 0, 5);
[YS,XS,ZS] = meshgrid(y_s,x_s,z_s);

%% CALCULATE STREAMFUNCTION

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, ZS, G, XS, YS);

%% CALCULATE TRAPPING CONTOURS/FIXED PTS

yf = zeros(size(z_s));
st = zeros(size(z_s));

for i = 1:length(z_s)
    if z_s(i) <= -sqrt(3)
        yf(i) = calc_ctfixedp(y1, z1, z_s(i), 2*z1); % Top saddle
    elseif z_s(i) > -sqrt(3)
        [~,yf(i),~] = calc_snfixedp(y1, z1, z_s(i)); % Side saddles
    end
    [~,~, ~, ~, st(i)] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
        z_s(i), G, 0, yf(i));
end

%% INITIALIZE FIGURE

f = figure;
hold on

%% PLOT TRAPPING CONTOURS AND GENERAL CONTOURS

lvlg = zeros(length(z_s),8);
lvlg(5,:) = linspace(-0.001,0.001,8);
lvlg(4,:) = linspace(-0.0025,0.001,8);
lvlg(3,:) = linspace(-0.0025,0.001,8);
lvlg(2,:) = linspace(-0.0025,0.001,8);
lvlg(1,:) = linspace(-0.001,0.001,8);
for i = 1:length(z_s)
   lvls = [st(i) st(i)];
   csl = contourslice(YS,XS,ZS,S,[],[],z_s(i),lvls);
   csg = contourslice(YS,XS,ZS,S,[],[],z_s(i),lvlg(i,:));
   set(csl,'linewidth',5,'edgecolor','k')
   set(csg,'linewidth',2,'edgecolor','b')
end

%% ELEMENTS OF DECORATION

xlabel('$y$', 'interpreter', 'latex')
ylabel('$x$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')
xlim([-s,s])
ylim([-s,s])
zlim([-zbif-2.5, 0+2.5])
view([135 25])
daspect([2 2 0.225])
grid on
box on
set(gca, 'linewidth', 5, 'fontsize',40)

%% GET PATCH COORDINATES

PAT = zeros(3,4,5);
xs = x_s(1); xe = x_s(end);
ys = y_s(1); ye = y_s(end); 

for i = 1:5
   PAT(1, :, i) = [xs, xe, xe, xs];
   PAT(2, :, i) = [ys, ys, ye, ye];
   PAT(3, :, i) = z_s(i)*[1, 1, 1, 1];
end

%% DRAW PATCHES

for i = 1:5
    patch(PAT(1,:,i), PAT(2,:,i), PAT(3,:,i), 'y', 'FaceAlpha', 0.3, 'Linewidth',...
        5, 'EdgeColor', [0, 0, 0]);
end