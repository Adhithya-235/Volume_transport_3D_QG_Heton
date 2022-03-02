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
z1 = 0; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE

z = 0;

%% CREATE MESH FOR VECTOR FIELD AND STREAMFUNCTION

xs = 4; ys = xs; zs = xs;
x_v = linspace(-xs,xs,800);       x_s = linspace(-xs,xs,1000);
y_v = linspace(-ys,ys,800);       y_s = linspace(-ys,ys,1000);
[XV,YV] = meshgrid(x_v, y_v);    [XS,YS] = meshgrid(x_s, y_s);

%% CALCULATE VECTOR FIELD AND STREAMFUNCTION OVER APPROPRIATE GRIDS

[XDOT, YDOT, ZDOT, L,~] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, ...
    XV, YV);

[~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, XS, YS);

%% CALCULATE FIXED POINTS 

%   The centers are prone to vanishing above a certain z. Do not panic. 

[xf,yf,zbif] = calc_snfixedp(y1, z1, z);            % Saddle-node
ycf_top      = calc_ctfixedp(y1, z1, z, 1.1);         % Top center
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

v1 = [SM, SM];
v2 = -0.1:0.02:0.1;
v3 = [ST,-1];
v4 = [SB,-1];

%% PLOT VECTOR FIELD

sx1 = zeros(25,1); %-4*ones(15,1);
sy1 = linspace(-4,4,25);
s1  = streamline(XV,YV,XDOT,YDOT,sx1,sy1);
s2  = streamline(XV,YV,-XDOT,-YDOT,sx1,sy1);
set(s1, 'Linewidth', 3, 'color', [0.5, 0.5, 0.5])
set(s2, 'Linewidth', 3, 'color', [0.5, 0.5, 0.5])

[avx, avy, avz, al,~] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, ...
    sx1, sy1');
q = arrows(sx1,sy1,avx./al,avy./al,'cartesian', [0.2,0.2,0.15,0]);

%% PLOT VARIOUS CONTOURS (GENERAL, TRAPPING, CENTER-ASSOCIATED)

%contour(XS, YS, S, v2, '-m', 'linewidth', 4, 'Showtext', 'off')

[C0, h]  = contour(XS, YS, S, v1, '-k', 'linewidth', 5, 'showtext', 'off');
%[C1, h1] = contour(XS, YS, S, v3, '-r', 'linewidth', 3, 'Showtext', 'off');
%[C2, h2] = contour(XS, YS, S, v4, '-b', 'linewidth', 4, 'Showtext', 'off');

%% PLOT FIXED POINTS

plot(0, 1, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
plot(0, -1, 'ok', 'linewidth', 2, 'markerfacecolor', 'b', 'markersize', 15)
plot(xf, yf, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)
plot(-xf,yf, 'ok', 'linewidth', 2, 'markerfacecolor', 'r', 'markersize', 15)

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