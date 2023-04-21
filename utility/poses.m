blue_b_approach = [-0.066, -0.46, 0.15, -pi,0,0] ;
blue_b = [-0.066, -0.46, 0.07, -pi,0,0] ;

bottleBin = [-0.35,-0.45,0.4,-pi,0,0];
canBin = [-0.35,0.45,0.4,-pi,0,0];


scale_bottle=0.034;
scale_can   = 0.033;
%scale=1
global can_fit bottle_fit bottle_flipped
can_fit = rmmissing(pcread("../models/can.ply").Location)*scale_can;
bottle_fit = rmmissing(pcread("../models/bottle.ply").Location)*scale_bottle;
Rzpi = [-1 0 0; 0 -1 0; 0 0 1];
bottle_flipped = (Rzpi*bottle_fit')';
global gripAct gripGoal
[gripAct,gripGoal] = rosactionclient('/franka_gripper/gripper_action');

grasp_bottle_up = [0, 0.085, 0];