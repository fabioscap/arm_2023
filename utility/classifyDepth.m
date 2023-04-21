function [class, obj, tf, ctr, dir] = classifyDepth(pc)
global can_fit bottle_fit bottle_flipped
% 0 is bottle
% 1 is can
% 2 is pouch
    % stupid check to see how large is the biggest eigenvalue of the pc
    % bottles are longer than cans so it has to be bigger
    class = max(eig(cov(pc))) <= 0.0023;

    % TODO replace numbers with strings
    if class == 1
        disp("can");
        % can
        [tf, obj, rmse] = modelfit(pc,can_fit);
        direction = [0; 1;0];
        center    = [0; 0;0];
    elseif class == 0 
        disp("bottle");
        % bottle
        % sometimes bottle shit fuck
        [tf1, obj1, rmse1] = modelfit(pc,bottle_fit);
        [tf2, obj2, rmse2] = modelfit(pc,bottle_flipped);
        if rmse1 < rmse2 % prevent shit fuck
            tf = tf1;
            obj = obj1;
            rmse = rmse1;
            direction = [0; 1; 0];
            center    = [0; 0; 0];
        else
            tf = tf2;
            obj = obj2;
            rmse = rmse2;
            direction = [0; -1; 0];
            center    = [0;  0; 0];
        end
    elseif class == 2
        % pouch TODO
        disp("pouch");
    else
        disp("penis");
    end

    % TRANSFORM THE CENTER AND THE DIRECTIONS
    dir = tf.R*direction;
    ctr = tf.transformPointsForward(center')';

    % TODO fit all models and look for the smallest rmse
    % to confirm classification

end

