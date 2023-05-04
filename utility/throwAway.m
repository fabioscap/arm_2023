function throwAway(target_bin)
%THROWAWAY Summary of this function goes here
%   Detailed explanation goes here
bottleBin = [-0.35,-0.45,0.3,-pi,0,0];
canBin = [-0.35,0.45,0.3,-pi,0,0];
if target_bin=="bottle"
    target = bottleBin;
    target_angle = -pi/2;
elseif target_bin=="can"
    target = canBin;
    target_angle = pi/2;
end
tftree = rostf;
camera_transf = getTransform(tftree, 'panda_link0', 'panda_EE','Timeout',inf);
camera_transl = camera_transf.Transform.Translation;
x = camera_transl.X;
y = camera_transl.Y;
moveTo([x,y,0.4,-pi,0,0],1,true);
theta = atan2(y,x);
delta_theta = target_angle-theta;
if abs(delta_theta)<pi/2
    moveTo(target);
else
    moveTo([0.4,0,0.5,-pi,0,0],1.5,true);
    moveTo(target,0);
end

pause(2);
moveGripper(0.04,50);
end

