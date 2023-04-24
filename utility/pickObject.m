function pickObject(type,position)
%PICKOBJECT Summary of this function goes here
%   Detailed explanation goes here
[m,argm] = max(position(4:6));
if type=="can"
    if argm~=3
        targetWidth = 0.035;
        force = 50;
        offset = 0.01+0.09;
        z_dir = atan2(position(5),position(4));
    else
        targetWidth = 0.035;
        force = 50;
        offset = 0.075;
        z_dir = 0;
    end
else
    if argm~=3
        targetWidth = 0.035;
        force = 20;
        offset = 0.075;
        z_dir = atan2(position(5),position(4));
    else
        targetWidth = 0.02;
        force = 20;
        offset = 0.11+0.085;
        z_dir = 0;
    end
    
end

moveTo([position(1:3)+[0,0,offset],-pi,0,z_dir],5,false,true,5);
moveGripper(0.04,50);
pause(1);
moveTo([position(1:3)+[0,0,offset-0.07],-pi,0,z_dir],0);
moveTo([position(1:3)+[0,0,offset-0.1],-pi,0,z_dir],0);
moveTo([position(1:3)+[0,0,offset-0.13],-pi,0,z_dir],2,false,true,2);
moveGripper(targetWidth,force);
pause(1);
end

function closeAngle = closestAngle(angle)
    angles = [0,pi,-pi,pi/2,-pi/2];
    diff = abs(angles-angle);
    [m,argmin] = min(diff);
    closeAngle = angles(argmin);
end