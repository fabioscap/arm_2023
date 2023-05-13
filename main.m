
% To run the program the correct IP address needs to the set.
rosIP = "192.168.1.221"; % IP address of ROS enabled machine 

% add all folders in the project to the path
addpath(genpath(pwd));
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