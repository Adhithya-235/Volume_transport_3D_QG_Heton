%=========================================================================%
%   Can I identify boxes in trapping region of the Heteroclinic regime    %
%   properly?                                                             %
%=========================================================================%

clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 10; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE, y-POSITION OF SADDLES, CALCULATE BOUNDING S VALUE

z = 0; 
[xf,yf,zbif] = calc_snfixedp(y1, z1, z);
[~, ~, ~, ~, SM] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);

%% CREATE MESH FOR STREAMFUNCTION, TOP HALF

xs  =  0;   ys = yf;
xe  =  50;   ye = xe;
hx  = 0.01;  hy = hx;
[dA, mx, my, MX, MY] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);

%% INITIALIZE BOX COUNTER

tcount = 0;

%% LOOP THROUGH BOXES, CHECKING STREAMFUNCTION VALUE, TOP HALF

% figure(1)
% hold all
% parfor i = 1:length(my)
%     for j = 1:length(mx)
%         [~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z,...
%             G, mx(j), my(i));
%         if S > SM
%             plot(mx(j),my(i),'Marker','s','MarkerEdgeColor','k',...
%                 'MarkerFaceColor','b')
%             grid on
%             xlim([xs,xe])
%             ylim([ys,ye])
%             tcount = tcount + 1;
%         else
%             plot(mx(j),my(i),'Marker','s','MarkerEdgeColor','k',...
%                 'MarkerFaceColor','r')
%             grid on
%             xlim([xs,xe])
%             ylim([ys,ye])
%             break;
%         end
%     end
% end
   
%% TOP HALF AREA

% cond = @gt;
% TRAT = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
%     SM, cond); 

%% CREATE MESH FOR STREAMFUNCTION, BOTTOM HALF

xs  =  0;   ys = -xe;
xe  =  50;   ye = yf;
hx  = 0.01;  hy = hx;
[dA, mx, my, MX, MY] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);

% %% INITIALIZE BOX COUNTER
% 
% bcount = 0;
% 
% %% LOOP THROUGH BOXES, CHECKING STREAMFUNCTION VALUE, BOTTOM HALF
% 
% figure(2)
% hold all
% parfor i = 1:length(my)
%     for j = 1:length(mx)
%         [~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z,...
%             G, mx(j), my(i));
%         if S < SM
%             plot(mx(j),my(i),'Marker','s','MarkerEdgeColor','k',...
%                 'MarkerFaceColor','b')
%             grid on
%             xlim([xs,xe])
%             ylim([ys,ye])
%             bcount = bcount + 1;
%         else
%             plot(mx(j),my(i),'Marker','s','MarkerEdgeColor','k',...
%                 'MarkerFaceColor','r')
%             grid on
%             xlim([xs,xe])
%             ylim([ys,ye])
%             break;
%         end
%     end
% end
   
%% BOTTOM HALF AREA

cond = @lt;
TRAB = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
    SM, cond); 

%% TOTAL AREA

TRA = TRAT + TRAB; 