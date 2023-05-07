global can_fit bottle_fit bottle_flipped Ymn Ymx Rmn Rmx net jointPub

home = [0.4,0,0.4,-pi,0,0];
blue_b_approach = [-0.066, -0.46, 0.15, -pi,0,0] ;
blue_b = [-0.066, -0.46, 0.07, -pi,0,0] ;

bottleBin = [-0.35,-0.45,0.3,-pi,0,0];
canBin = [-0.35,0.45,0.3,-pi,0,0];

scale_bottle=0.034;
scale_can   = 0.033;
%scale=1
can_fit = rmmissing(pcread("models/can.ply").Location)*scale_can;
bottle_fit = rmmissing(pcread("models/bottle.ply").Location)*scale_bottle;
Rzpi = [-1 0 0; 0 -1 0; 0 0 1];
bottle_flipped = (Rzpi*bottle_fit')';

grasp_bottle_up = [0, 0.085, 0];
scale_pos = [0.61 0.38 -0.03, -pi, 0, 0];

% Yellow region bounds
Ymn = [0+0.1,-0.3,0.52-0.615];
Ymx = [0.35+0.1,0.27,10-0.615];
% Red region bounds
Rmn = [0.65,-0.21,0.52-0.615];
Rmx = [1,0.25,10-0.615];

jointPub = rospublisher("/cartesian_impedance_example_controller/equilibrium_pose");
pause(2);
net = load("detector.mat").detector;