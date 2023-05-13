function [done,eePosition,eeQuaternion] = moveToInterp(position, n_steps)
%MOVETO Move the end-effector to a target position with intermediate steps
%   Inputs:
%       position: 6-dimensional vector containing target position and orientation
%       of the end-effector
%       n_steps: how many intermediate steps to do
%   Outputs:
%       done: true if target position was reached
%       eePosition: position reached by the end-effector
%       eeQuaternion: orientation reached by the end-effector
    arguments
        position
        n_steps = 10;
    end
    % trajectory with linear interpolation
    
    % get EE position (maybe write a function for this?)
    tftree = rostf;
    pause(1);
    transf = getTransform(tftree, 'panda_link0', 'panda_EE','Timeout',inf); 
    transl = transf.Transform.Translation;
    currP = [transl.X,transl.Y,transl.Z];
    desP  = position(1:3);
    t = 0:1/n_steps:1;

    positions = currP' + t.*(desP'-currP');
    
    for i=1:n_steps
        p_i = positions(:,i)';
        pose_i = [p_i, position(4:6)];
        if i == n_steps
            [done,eePosition,eeQuaternion] = moveTo(pose_i);
        else
            moveTo(pose_i,1,true);
        end

    end

end