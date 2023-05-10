% add all folders in the project to the path
addpath(genpath(pwd));
% IMPORTANT: Change IP address according to your env in startROS.m !!!!!!!  
startROS;
initialization;
% we get objects in the yellow region, we need to classify them
pickYellow;
% we pick all the fixed objects
pickStatic;
% we weight and pick almost all the pouches
getPouches;
% 
pickRed;
%
pickBox;