clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

YV = 1;
ZV = [0];

%% CREATE FIGURE AND POPULATE

f = figure;
hold on
xlabel('$x$', 'interpreter', 'latex')
ylabel('$y$', 'interpreter', 'latex')
zlabel('$z$', 'interpreter', 'latex')

for i = 1:length(ZV)
    
    %% FIX Y VALUE
    
    Z = ZV(i);
    
    %% CREATE z GRID
    
    z = linspace(-sqrt(3), sqrt(3), 500);
    
    %% COMPUTE FIXED POINTS
    
    xs = sqrt((3 - z.^2)*(1 + Z^2));
    ys = -z*Z;
    
    %% PLOT
    
    if i == 1
        plot3(xs, ys, z, 'color', [0.5, 0.5, 0.5], 'linewidth', 4)
        plot3(-xs, ys, z, 'color', [0.5, 0.5, 0.5], 'linewidth', 4)
    else     
        plot3(xs, ys, z, 'r--', 'linewidth', 4)
        plot3(-xs, ys, z, 'r--', 'linewidth', 4)
    end
end

%% ELEMENTS OF DECORATION

xlim([-4, 4])
ylim([-4, 4])
zlim([-4, 4])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
grid on 
box on 
%view([90, 0])
