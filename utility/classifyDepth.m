function [type, obj, tf, ctr, dir, rmse] = classifyDepth(pc)
global can_fit bottle_fit bottle_flipped
% 0 is bottle
% 1 is can
% 2 is pouch
    % stupid check to see how large is the biggest eigenvalue of the pc
    % bottles are longer than cans so it has to be bigger
    [tf1, obj1, rmse1] = modelfit(pc,can_fit);
    [tf2, obj2, rmse2] = modelfit(pc,bottle_fit);
    [tf3, obj3, rmse3] = modelfit(pc,bottle_flipped);
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

    if class==1
        type = "can";
    elseif class==2 || class==3
        type = "bottle";
    else
        type = "pouch";
    end
    
    % TRANSFORM THE CENTER AND THE DIRECTIONS
    dir = tf.R*direction;
    ctr = tf.transformPointsForward(center')';
end

