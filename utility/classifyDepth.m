function [type, obj, tf, ctr, dir, rmse] = classifyDepth(pc)
%CLASSIFYDEPTH Takes a pointcloud of an objects and fits the models
%of the bottle and the can to it to find the best match.
%   Inputs:
%       pc: pointcloud to classify
%   Outputs:
%       type: the type of the object with the best fit. Either "bottle" or "can"
%       obj: the transformed model of the fitted object
%       tf: the transform obtained from the fit
%       ctr: a 3-dimensional vector of the found center of the object.
%       dir: a 3-dimensional vector of the found orientation of the object
%       rmse: the root mean square error of the fit, calculated over the
%       points of the models, not of the pc
    global can_fit bottle_fit bottle_flipped
    % 0 is bottle
    % 1 is can
    % 2 is pouch
    [tf1, obj1, rmse1] = modelfit(pc,can_fit);
    [tf2, obj2, rmse2] = modelfit(pc,bottle_fit);
    [tf3, obj3, rmse3] = modelfit(pc,bottle_flipped);
    rmse1 = getRMSE(pc, obj1);
    rmse2 = getRMSE(pc, obj2);
    rmse3 = getRMSE(pc, obj3);

    [m,class] = min([rmse1,rmse2,rmse3]);
    tfs = [tf1,tf2,tf3];
    objs = {obj1,obj2,obj3};
    rmses = [rmse1,rmse2,rmse3];
    tf = tfs(class);
    obj = objs{class};
    rmse = rmses(class);

    direction = [0; 1;0];
    if class==3
        direction = direction*-1;
    end
    center    = [0; 0;0];
    pcshow(obj,'r');
    % pcshow(obj1,'r');
    % pcshow(obj2,'b');
    % pcshow(obj3,'g');

    if class==1
        type = "can";
    elseif class==2 || class==3
        type = "bottle";
    else
        type = "pouch";
    end
    
    % TRANSFORM THE CENTER AND THE DIRECTIONS
    dir = tf.R*direction;
    if dir(1)<-0.9
        dir(1) = -dir(1);
    end
    ctr = tf.transformPointsForward(center')';
end

