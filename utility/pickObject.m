function pickObject(type,position)
%PICKOBJECT Summary of this function goes here
%   Detailed explanation goes here
if type=="can"
    if abs(closestAngle(position(4)))==pi/2 || abs(closestAngle(position(5)))==pi/2
        targetWidth = 0.035;
        force = 50;
        offset = 0.01;
    else
        targetWidth = 0.035;
        force = 50;
        offset = 0.075;
    end
else
    if abs(closestAngle(position(4)))==pi/2 || abs(closestAngle(position(5)))==pi/2
        targetWidth = 0.035;
        force = 20;
        offset = 0.075;
    else
        targetWidth = 0.02;
        force = 20;
        offset = 0.11;
    end
    
end

moveTo([position(1:3)+[0,0,offset],-pi,0,0],5);
moveGripper(0.04,50);
pause(1);
moveTo([position(1:3)+[0,0,offset-0.07],-pi,0,0],0);
moveTo([position(1:3)+[0,0,offset-0.1],-pi,0,0],0);
moveTo([position(1:3)+[0,0,offset-0.13],-pi,0,0],2);
moveGripper(targetWidth,force);
pause(5);
end

function closeAngle = closestAngle(angle)
    angles = [0,pi,-pi,pi/2,-pi/2];
    diff = abs(angles-angle);
    [m,argmin] = min(diff);
    closeAngle = angles(argmin);
end