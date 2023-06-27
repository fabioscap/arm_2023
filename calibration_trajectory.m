% To run the program the correct IP address needs to the set.
rosIP = "10.10.231.171"; % IP address of ROS enabled machine 

% add all folders in the project to the path
addpath(genpath(pwd));
startROS;
initialization;
x = -pi/2:0.1:3/2*pi+0.1;

center = [0.5;0;0.5];
scale = [0.2;0.5;1];

v = cat(1,infty(x),zeros(1,length(x))).*scale+center;
v = cat(2,v,v);

orientations = [-pi, 0, 0];
z_car = -0.02:0.04/15:0.02;
z_car = cat(2,z_car,(-0.02:0.04/15:0.02)*-1);
z_car = repmat(z_car, [1,10]);
z_rot = -pi/2:pi/10:pi/2;
z_rot = cat(2,z_rot,(-pi/2:pi/10:pi/2)*-1);
z_rot = repmat(z_rot, [1,10]);
x_rot = -pi/12:pi/36:pi/12;
x_rot = cat(2,x_rot,(-pi/12:pi/36:pi/12)*-1);
x_rot = repmat(x_rot, [1,10]);
y_rot = -pi/12:pi/39:pi/12;
y_rot = cat(2,y_rot,(-pi/12:pi/39:pi/12)*-1);
y_rot = repmat(y_rot, [1,10]);
for i=1:128
    moveTo(cat(2,v(:,i)'+[0,0,z_car(i)],orientations(1,:)+[x_rot(i),y_rot(i),z_rot(i)]),0.0,true);
end
function y = infty(x)
y = [cos(x); sin(x).*cos(x)];
end