function [point, yaw, gripper_width] = getGraspPoint(class, ctr, dir)
    % TODO SET BETTER WIDTH, EFFORT
    % CURRENTLY ONLY GRASP BOTTLES BY CAP
    gripper_width = 0.065;
    % upright or not
    dir
    if abs(dot(dir,[0;0;1])) > 0.95
        % object is upright
        upright = true;
        yaw = 0;
    else
        % sdraiato
        upright = false;
        yaw = acos(abs(dir(1)));
        
    end
    yaw
    % TODO replace numbers with strings
    if class == 0
        if upright
            point = ctr + [0;0;0.075];
        else
            point = ctr;
        end
        gripper_width = 0.034;
    elseif class == 1
        if upright

        else
            point = ctr;
        end
    elseif class == 2
        ...
    end
    point = point'; % stupid MATLAB®
end

