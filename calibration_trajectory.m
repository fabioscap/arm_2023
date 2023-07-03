% To run the program the correct IP address needs to the set.
rosIP = "192.168.0.43"; % IP address of ROS enabled machine 

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

z_rot = 0:pi/(2*15):pi/2;
z_rot2 = pi/2-z_rot;
z_rot = cat(2,z_rot,z_rot2);
z_rot = cat(2,z_rot,-z_rot);

x_rot = 0:pi/(12*15):pi/12;
x_rot2 = pi/12-x_rot;
x_rot = cat(2,x_rot,x_rot2);
x_rot = cat(2,-x_rot,x_rot);

y_rot = 0:pi/(12*15):pi/12;
y_rot2 = pi/12-y_rot;
y_rot = cat(2,y_rot,y_rot2);
y_rot = cat(2,y_rot,-y_rot);

for i=1:128
    moveTo(cat(2,v(:,i)'+[0,0,z_car(i)],orientations(1,:)+[x_rot(i),y_rot(i),z_rot(i)]),0.0,true);
end
function y = infty(x)
y = [cos(x); sin(x).*cos(x)];
end