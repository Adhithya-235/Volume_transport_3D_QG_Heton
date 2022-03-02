%=========================================================================%
%   Can I identify boxes in trapping region of the Homoclinic regime      %
%   properly?                                                             %
%=========================================================================%

clear
close all
clc

%% HETON POSITION AND STRENGTH

x1 = 0; x2 = -x1;
y1 = 1; y2 = -y1;
z1 = 1; z2 = -z1;
G  = 1;

%% SPECIFY z PLANE, y-POSITION OF SADDLES, CALCULATE BOUNDING S VALUE

z = sqrt(3)+1; 
yf = calc_ctfixedp(y1, z1, z, -1);
[~, ~, ~, ~, SB] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z, G, 0, yf);

%% CREATE MESH FOR STREAMFUNCTION, TOP HALF

xs  =  0;   ys = yf;
xe  =  3;   ye = xe;
hx  = 0.1;  hy = hx;
[dA, mx, my, MX, MY] = cret_mdptmesh_2d(xs, xe, ys, ye, hx, hy);

% %% INITIALIZE BOX COUNTER
% 
% tcount = 0;
% 
% %% LOOP THROUGH BOXES, CHECKING STREAMFUNCTION VALUE, TOP HALF
% 
% figure(1)
% hold all
% for i = 1:length(my)
%     for j = 1:length(mx)
%         [~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z,...
%             G, mx(j), my(i));
%         if S > SB
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

cond = @gt;
TRAT = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
    SB, cond); 
