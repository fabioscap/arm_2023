function pickObject(type, position, z_dir, approach_orientation)
%PICKOBJECT Function to pick an object with the gripper
%   Inputs:
%       type: type of the pbject. Either "bottle" or "can"
%       position: 6-dimensional vector with position and orientation of the
%       object
%       z_dir: the rotation around the z axis that the end-effector needs 
%       to pick up the object
%       approach_orientation: a 3-dimensional vector with XYZ angles that
%       the end-effector needs to pick up the object
%   Outputs:
%
arguments
        type = "bottle"
        position = [0,0,0];
        z_dir = 0;
        approach_orientation = [-pi,0,0];
end
[m,argm] = max(abs(position(4:6)));
if type=="can"
    if argm~=3
        targetWidth = 0.035;
        force = 20;
        offset = 0.01+0.105;
    else
        targetWidth = 0.035;
        force = 20;
        offset = 0.1;
    end
else
    if argm~=3
        targetWidth = 0.035;
        force = 30;
        offset = 0.01+0.105;
    else
        targetWidth = 0.018;
        force = 20;
        offset = 0.11+0.085;
    end 
end
moveTo([position(1:3)+[0,0,offset],-pi,0,z_dir],3,false,true,2);
moveGripper(0.04,50);
pause(1);
if approach_orientation ~= [-pi,0,0]
    moveTo([position(1:3)+[0,0,offset],approach_orientation+[0,0,z_dir]],2);
end
moveTo([position(1:3)+[0,0,offset-0.07],approach_orientation+[0,0,z_dir]],0);
moveTo([position(1:3)+[0,0,offset-0.1],approach_orientation+[0,0,z_dir]],0);
moveTo([position(1:3)+[0,0,offset-0.13],approach_orientation+[0,0,z_dir]],2);
moveGripper(targetWidth,force);
pause(1);
end