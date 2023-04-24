home = [0.4,0,0.4,-pi,0,0];
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

grasp_bottle_up = [0, 0.085, 0];


scale_pos = [0.61 0.38 -0.03, -pi, 0, 0];

