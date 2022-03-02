clear
close all
clc

%% FIX HETON LOCATION PARAMETERS

YV = [0.5, 1, 2];
Z = 0;

%% CREATE FIGURE AND POPULATE

f = figure;
hold on
xlabel('$x$', 'interpreter', 'latex')
ylabel('$z$', 'interpreter', 'latex')

for i = 1:3
    
    %% FIX Y VALUE
    
    Y = YV(i);
    
    %% CREATE xz MESH

    s = Y*sqrt(3);
    z = linspace(-s, s, 0.5*4096);
    
    %% COMPUTE FIXED POINTS
    
    xs = sqrt(3*Y*Y - z.^2); 
    
    %% PLOT
    
    plot(xs, z, 'r--', 'linewidth', 4)
    plot(-xs, z, 'r--', 'linewidth', 4)

end

%% ELEMENTS OF DECORATION

xlim([-4, 4])
ylim([-4, 4])
axis square
set(gca, 'fontsize', 40, 'linewidth', 5)
box on 
