%=========================================================================%
%   Compute the value of the trapping streamline psi_u.                   %
%=========================================================================%
clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = [1 3 5 10]; z2 = -z1;
G  = 1;

%% GUESS zb2 LOCATION (FROM study_yaxisfps_2.m)

guess = [-0.318514899853444   3.183635888746892;...
    -2.945774303859307   9.538884684918465;...
    -6.634098680996581  17.757994120788322;...
    -18.441621885686370  42.962349212649585];

%% SOLUTIONS IN CELL ARRAY

psiu = cell(1,length(z1));
z    = cell(1,length(z1));

%% COMPUTE psiu

for i = 1:length(z1)
    [psiu{i}, z{i}] = compute_psiu(x1,x2,y1,y2,z1(i),z2(i),G,guess(i,:));
end

%% PLOT psiu

figure(1)
hold on
for i = 1:length(z1)
    plot(z{i},psiu{i},'-','linewidth',5)
    plot(z{i}(end), psiu{i}(end), 'ko', 'linewidth', 5)
end
xlabel('$z$','interpreter','latex')
ylabel('$\psi_u$','interpreter','latex')
axis tight
axis square
box on
grid on
set(gca, 'fontsize', 40, 'linewidth', 5)

%% PLOT psiu/z1^(4/3)

figure(2)
hold on
for i = 1:length(z1)
    plot(z1(i), psiu{i}(end), 'ko', 'linewidth', 5)
end
xlabel('$Z$','interpreter','latex')
ylabel('$\psi_u(z_b^2)$','interpreter','latex')
axis tight
axis square
box on
grid on
set(gca, 'fontsize', 40, 'linewidth', 5, 'xscale', 'log', 'yscale', 'log')
%% FUNCTIONS TO USE

function[psiu, z] = compute_psiu(x1,x2,y1,y2,z1,z2,G,guess)

%% REFINE GUESS

bifpt = calc_zbifpt_2(y1, z1, guess);

%% GUESS FOR ycf_bot

if z1 < 10
    ycg = -1.1;
else
    ycg = -z1;
end

%% GET z-GRID

z = linspace(0, bifpt(2), 500)';

%% GET SOLUTION ARRAY

psiu = zeros(size(z));

%% COMPUTE psiu

swtch = 0;
for i = 1:length(z)
   if z(i) < sqrt(3)
       [~,yf,~] = calc_snfixedp(y1, z1, z(i));
       [~,~,~,~,psiu(i)] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
           z(i), G, 0, yf);
   elseif z(i) >= sqrt(3)
       if swtch == 0
           ycf_bot = calc_ctfixedp(y1, z1, z(i), ycg); 
           [~,~,~,~,psiu(i)] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
               z(i), G, 0, ycf_bot);
           ycbold = ycf_bot;
           swtch = 1;
       else 
           ycf_bot = calc_ctfixedp(y1, z1, z(i), ycbold);
           [~,~,~,~,psiu(i)] = calc_streamfcn(x1, x2, y1, y2, z1, z2,...
               z(i), G, 0, ycf_bot);
           ycbold = ycf_bot;
       end
   end
end

end
