function A = calc_trarea(x1, x2, y1, y2, z1, z2, z, G, mx, my, dA,...
    SC, cond)

% Calculates the trapping area associated with a heton with vortices at
% (x1,y1,z1) and (x2,y2,z2), of strength G, and at plane z. This is done by
% searching over a rectangular region defined by the grids mx and my, and
% checking if the streamfunction value S at each (mx, my) satisfies a
% condition defined by the function handle 'cond' and the value of the
% streamfunction at the trapping contour SC. Points that do are counted and
% used to calculate the trapping area. Assumes area is symmetric along x.  

%% INITIALIZE COUNTER

count = 0;

%% COUNT BOXES THAT SATISFY CRITERIA

%   The first column in the first row always satisfies the criterion, i.e
%   it is always a part of the trapping region. 

parfor i = 1:length(my)      % In a particular row
    for j = 1:length(mx)     % In a particular column
        [~, ~, ~, ~, S] = calc_streamfcn(x1, x2, y1, y2, z1, z2, z,...
            G, mx(j), my(i));
        if cond(S, SC)
            count = count + 1; 
        else
            break;
        end
    end
end

%% COMPUTE AREA

A = 2*count*dA; 

end