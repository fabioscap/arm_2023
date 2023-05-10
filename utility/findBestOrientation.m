function [z_dir, approach_orientation] = findBestOrientation(type, position, pc_obj, pc_world)
%FINDBESTORIENTATION Summary of this function goes here
%   Detailed explanation goes here

[m,argm] = max(abs(position(4:6)));
if type=="can"
    if argm~=3
        offset = 0.016;
        z_dir = atan2(-position(5),position(4))+pi/2;
    else
        offset = 0.06;
        z_dir = +pi/2;
    end
else
    if argm~=3
        offset = 0.016;
        z_dir = atan2(position(5),position(4))+pi/2;
    else
        offset = 0.05;
        z_dir = +pi/2;
    end
end

n_rotations = 0;
if argm==3
    while n_rotations < 4
        center_xy = position(1:2);
        v1 = center_xy+[cos(z_dir),sin(z_dir)]*0.1+[sin(z_dir),-cos(z_dir)]*0.02;
        v2 = center_xy+[cos(z_dir),sin(z_dir)]*0.1+[sin(z_dir),-cos(z_dir)]*-0.02;
        v3 = center_xy+[cos(z_dir),sin(z_dir)]*-0.1+[sin(z_dir),-cos(z_dir)]*-0.02;
        v4 = center_xy+[cos(z_dir),sin(z_dir)]*-0.1+[sin(z_dir),-cos(z_dir)]*0.02;
        vrt_x = [v1(1),  v2(1),  v3(1),  v4(1)];
        vrt_y = [v1(2),  v2(2),  v3(2),  v4(2)];
        in_points = inpolygon(pc_world(:,1),pc_world(:,2), vrt_x, vrt_y);
        pcClose = pc_world(in_points,:);
        pcCloseValid = pcClose;
        pcCloseValid(ismember(pcClose,pc_obj,'rows')) = NaN;
        mn = [-10,-10,position(3)+offset-0.06];
        mx = [10,10,10];
        pcCV = pointCloud(pcCloseValid);
        pcCloseValidZ = pcrestrict(pcCV.Location, mn, mx);

        % figure;
        % pcshow(pc_world,'b')
        % hold on
        % pcshow(pcClose,'y')
        % pcshow(pcCloseValidZ,'r');

        if length(pcCloseValidZ)>10
            z_dir = z_dir + pi/4;
            n_rotations = n_rotations + 1;
        else
            break
        end
    end
    approach_orientation = [-pi,0,0];
else
    center_xy = position(1:2);
    v1 = center_xy+[cos(z_dir),sin(z_dir)]*0.1+[sin(z_dir),-cos(z_dir)]*0.02;
    v2 = center_xy+[cos(z_dir),sin(z_dir)]*0.1+[sin(z_dir),-cos(z_dir)]*-0.02;
    v3 = center_xy+[cos(z_dir),sin(z_dir)]*-0.1+[sin(z_dir),-cos(z_dir)]*-0.02;
    v4 = center_xy+[cos(z_dir),sin(z_dir)]*-0.1+[sin(z_dir),-cos(z_dir)]*0.02;
    vrt_x = [v1(1),  v2(1),  v3(1),  v4(1)];
    vrt_y = [v1(2),  v2(2),  v3(2),  v4(2)];
    in_points = inpolygon(pc_world(:,1),pc_world(:,2), vrt_x, vrt_y);
    pcClose = pc_world(in_points,:);
    pcCloseValid = pcClose;
    pcCloseValid(ismember(pcClose,pc_obj,'rows')) = NaN;
    if length(pcCloseValid)>10
        % CONTINUE ADDING MAYBE AVERAGE OF THE POINTS AND THEN CALCULATE
        % BEST approach_orientation
    end
    approach_orientation = [-pi,0,0];
end

z_dir = z_dir - pi/2;
if abs(abs(z_dir)-pi)<0.005
    z_dir=0;
end

end
