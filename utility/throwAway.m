function throwAway(target_bin, n_steps)
%THROWAWAY Summary of this function goes here
%   Detailed explanation goes here
bottleBin = [-0.35,-0.45,0.4,-pi,0,0];
canBin = [-0.35,0.45,0.4,-pi,0,0];
if target_bin=="bottle"
    target = bottleBin;
    target_angle = -pi;
elseif target_bin=="can"
    target = canBin;
    target_angle = pi;
end

tftree = rostf; %finds TransformationTree directly from ros
pause(1);
camera_transf = getTransform(tftree, 'panda_link0', 'panda_EE');
camera_transl = camera_transf.Transform.Translation;
x = camera_transl.X;
y = camera_transl.Y;
z = camera_transl.Z;
moveTo([x,y,0.4,-pi,0,0],0);
% radius = sqrt(x^2+y^2);
% if radius<0.2
%     radius = 0.2;
% end
radius=0.3;
theta = atan2(y,x);
delta_theta = target_angle-theta;
if abs(delta_theta)<pi/3
    moveTo(target);
else
%     for i=1:n_steps
%         angle = theta+delta_theta/(n_steps+1);
%         moveTo([radius*cos(angle),radius*sin(angle),0.4,-pi,0,0],0);
%     end
    moveTo([0.4,0,0.4,-pi,0,0]);
    moveTo(target);
end
moveGripper(0.04,10);
end

