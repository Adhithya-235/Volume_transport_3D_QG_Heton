function d = calc_cfpdist(y1, z1, z)
%   Calculate the distance between the top and bottom fixed points on the
%   axis x = 0 for a given values of z and heton position (y1, z1). 

%% INITIAL GUESSES FOR VARIOUS Z VALUES

if (0<z1)&&(z1<=2)
    yg_t = 1;
    yg_b = -1;
else
    yg_t = z1-1;
    yg_b = -z1+1;
end

%% CALCULATE DISTANCE

ycf_t = calc_ctfixedp(y1, z1, z, yg_t);
ycf_b = calc_ctfixedp(y1, z1, z, yg_b);
d     = abs(ycf_t - ycf_b);

end