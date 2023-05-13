
% To run the program the correct IP address needs to the set.
rosIP = "192.168.1.57"; % IP address of ROS enabled machine 

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
% we pick some objects from the "red" zone
pickRed;
% we try to pick some objects from the box
pickBox;