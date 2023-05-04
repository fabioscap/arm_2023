% Use hostname -I
rosIP = "192.168.1.121"; % Change IP address!!    % IP address of ROS enabled machine 

rosshutdown; % shut down existing connection to ROS
rosinit(rosIP,11311);
% rosinit(rosIP,'NodeHost','192.168.68.120') % Try specifying node host IP in case that there are multiple network adapters

setInitialConfig_franka; % DO NOT MODIFY

physicsClient = rossvcclient('gazebo/unpause_physics'); %unpause physics
physicsResp = call(physicsClient,'Timeout',3); %send default message