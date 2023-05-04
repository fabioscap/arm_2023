% add all folders in the project to the path
addpath(genpath(pwd));
% IMPORTANT: Change IP address according to your env in startROS.m !!!!!!!  
startROS;
poses;
global net
global jointPub
jointPub = rospublisher("/cartesian_impedance_example_controller/equilibrium_pose");
% pointCloudSub = rossubscriber('/camera/depth/points');
pause(2);
net = load("detector.mat").detector;
% we pick all the fixed objects
pickStatic;
% we get objects in the yellow region, we need to classify them
pickYellow;
% we weight and pick almost all the pouches
getPouches;
