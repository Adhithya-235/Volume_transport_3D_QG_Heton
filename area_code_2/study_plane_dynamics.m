%=========================================================================%
%   Study passive particle dynamics due to a single 3D heton in a         %
%   particular z = constant plane.                                        % 
%=========================================================================%

clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 10; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE

z = -10.725000000000001;
%% CREATE MESH FOR VECTOR FIELD AND STREAMFUNCTION

xs = 60; ys = xs;
x_v = linspace(-xs+0.05,xs,18);         x_s = linspace(-xs,xs,1000);
y_v = linspace(-ys+0.2,ys-0.2,25); y_s = linspace(-ys,ys,1000);
[XV,YV] = meshgrid(x_v, y_v);    [XS,YS] = meshgrid(x_s, y_s);

%% CALCULATE VECTOR FIELD AND STREAMFUNCTION OVER APPROPRIATE GRIDS

[XDOT, YDOT, ZDOT, L,~] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, ...
    XV, YV);

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, XS, YS);

%% CALCULATE FIXED POINTS 

%   The centers are prone to vanishing above a certain z. Do not panic. 

[xf,yf,zbif] = calc_snfixedp(y1, z1, z);            % Saddle-node
ycf_top      = calc_ctfixedp(y1, z1, z, 2*z1);         % Top center
ycf_bot      = calc_ctfixedp(y1, z1, z, -1.1);        % Bottom center

%% CALCULATE STREAMFUNCTION VALUES OVER THE TRAPPING CONTOURS

% The trapping contours are heteroclinic connections between unstable fixed
% points. 

[~,~, ~, ~, SM] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);

%% CALCULATE STREAMFUNCTION VALUES ON OTHER FIXED POINTS

[~,~, ~, ~, ST] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, ycf_top);
[~,~, ~, ~, SB] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, ycf_bot);

%% INITIALIZE FIGURE

f = figure;
hold on

%% SPECIFY VARIOUS CONTOUR LEVELS

v1 = [ST, ST];
v2 = linspace(-0.0025,0.001,8);
v3 = [ST,-1];
v4 = [SB,-1];

%% PLOT VECTOR FIELD

%quiver(XV,YV,XDOT./L,YDOT./L,1,'Color',[0 0.95 0],'linewidth',2)
%quiver(XV,YV,XDOT./L,YDOT./L,0.75,'Color',[0 0.95 0],'linewidth',1, 'MaxHeadSize', 1);

%% PLOT VARIOUS CONTOURS (GENERAL, TRAPPING, CENTER-ASSOCIATED)

contour(XS, YS, S, v2, '-m', 'linewidth', 4, 'Showtext', 'on')

[C0, h]  = contour(XS, YS, S, v1, '-k', 'linewidth', 5, 'showtext', 'on');
%[C1, h1] = contour(XS, YS, S, v3, '-r', 'linewidth', 3, 'Showtext', 'off');
%[C2, h2] = contour(XS, YS, S, v4, '-b', 'linewidth', 4, 'Showtext', 'off');

%% PLOT FIXED POINTS

%plot(0, ycf_top, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
%plot(0, ycf_bot, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
%plot(xf, yf, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)
%plot(-xf,yf, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)

%% LEGEND

%legend([h, h2], {['\Psi = ', num2str(SM)], ['\Psi = ', num2str(SB)]})

%% TITLE AND AXIS LABELS

xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
%title(sprintf('Phase portrait, z = %1.4f, Z = %d', z, z1)); 

%% AXIS LIMITS AND ASPECT RATIO

xlim([x_s(1) x_s(end)])
ylim([y_s(1) y_s(end)])
axis square

%% ELEMENTS OF DECORATION

grid off
box on
set(gca, 'fontsize', 40, 'linewidth', 5)

%% CHECK

SM
xf
yf
ycf_bot
ycf_top