%=========================================================================%
% Plot fixed points on the y-axis (x = 0) using MATLAB's built-in         %
% rootfinding and minimization algorithms. In the plot, stable FPs are    %
% coded blue solid, and unstable FPs (saddles) are coded red dashed.      %
%=========================================================================%

clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

Y = 1;
Z = 10;

%% PLOT AXIS LIMITS

s = 45;

%% INITIAL GUESS FOR CENTER-SADDLE BIFURCATION (FROM study_yaxisfps_2.m)

guess = [-18.441621885686370  42.962349212649585];

%% FIND OUT WHERE THE CENTER-SADDLE BIFURCATION OCCURS 

bifpt = calc_zbifpt_2(Y, Z, guess);

%% FIX VALUES OF z 

N = 1000;
z2 = linspace(0, sqrt(3), N);    %Regime II, Top Center, Bottom Center
z3 = linspace(sqrt(3), bifpt(2), N); %Regime III, Top Center, Bottom Saddle

%% CREATE SOLUTION ARRAYS

YFT2 = zeros(N,1); %Top Fixed Points, Regime II
YFB2 = zeros(N,1); %Bottom Fixed Points, Regime II
YFT3 = zeros(N,1); %Top Fixed Points, Regime III
YFB3 = zeros(N,1); %Bottom Fixed Points, Regime III

%% INITIALIZE SOLUTION ARRAYS

YFT2(1) = calc_ctfixedp(Y, Z, z2(1), 0.99);   % B
YFB2(1) = calc_ctfixedp(Y, Z, z2(1), -0.99);  % B
YFT3(1) = calc_ctfixedp(Y, Z, z3(1), 0.99);   % B
YFB3(1) = calc_ctfixedp(Y, Z, z3(1), -Z);  % R

%% CALCULATE FIXED POINTS

for i = 2:N
    YFT2(i) = calc_ctfixedp(Y, Z, z2(i), YFT2(i-1));  % B
    YFB2(i) = calc_ctfixedp(Y, Z, z2(i), YFB2(i-1));  % B
    YFT3(i) = calc_ctfixedp(Y, Z, z3(i), YFT3(i-1));  % B
    YFB3(i) = calc_ctfixedp(Y, Z, z3(i), YFB3(i-1));  % R   
end

%% INITIALIZE FIGURE

f = figure;
hold on

%% AXIS LABELS AND SIZES

xlabel('$y$', 'interpreter', 'latex')
ylabel('$z$', 'interpreter', 'latex')
%title(['Z = ', num2str(Z)])
%grid on
xlim([-s, s])
ylim([-s, s])
axis square
box on
set(gca, 'fontsize', 40, 'linewidth', 5)

%% PLOT COMPUTED POINTS

plot(YFT2, z2, 'b.', 'linewidth', 4)
plot(YFB2, z2, 'b.', 'linewidth', 4)
plot(YFT3, z3, 'b-', 'linewidth', 4)
plot(YFB3, z3, 'r--', 'linewidth', 4)

%% REFLECT POINTS ABOUT ORIGIN

plot(-YFT2, -z2, 'b.', 'linewidth', 4)
plot(-YFB2, -z2, 'b.', 'linewidth', 4)
p2 = plot(-YFT3, -z3, 'b-', 'linewidth', 4);
p1 = plot(-YFB3, -z3, 'r--', 'linewidth', 4);

%% PLOT MIRROR AXES

%y = linspace(-s, s, 1000);
%plot(y, -y, 'm--', 'linewidth', 2)
%plot(y, -2*y, 'm--', 'linewidth', 2)

%% CREATE LEGEND

%legend([p1,p2], 'Saddle', 'Center')

%% REPORT DISTANCE

dist = YFT3(end) - YFB3(end)

%% SAVE VARIABLES

save yaxisfpZ10.mat z2 YFT2 YFB2 z3 YFT3 YFB3
