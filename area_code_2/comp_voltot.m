%=========================================================================%
%   Calculate the variation of trapped volume with Z.                     %
%=========================================================================%

clear
close all
clc

%% LOAD FILE

fnums = 1;
fname = sprintf('../import_2/guess/guess_%d.mat', fnums); 
load(fname);

%% SELECT h and XE

h = 0.01;
XE = 4;

%% CREATE SOLUTION VECTORS

VV = zeros(size(Z))';
AA{1, length(Z)} = [];
zz{1, length(Z)} = [];

%% FIND VOLUME

for i = 1:length(Z)
   i
   [VV(i), AA{i}, zz{i}] = calc_voltot(h, h, Z(i), XE, guess(i, :)); 
end

%% SAVE

save volm_1.mat Z zz AA VV; 

