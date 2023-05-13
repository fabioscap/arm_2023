function [theta] = pouchOrient(pc)
%PICKOBJECT Finds the z-angle of a pounch from its pointcloud
%   Inputs:
%       pc: pointcloud of the pouch
%   Outputs:
%       theta: rotation of the pounch around the z-axis
    % try to find the vertexes
    [~, xmax_idx] = max(pc(:,1));
    [~, ymax_idx] = max(pc(:,2));
    [~, xmin_idx] = min(pc(:,1));
    [~, ymin_idx] = min(pc(:,2));
    
    % problems when orientation is close to 0
    v1 = pc(xmax_idx,:);
    v2 = pc(ymax_idx,:);
    v3 = pc(xmin_idx,:);
    v4 = pc(ymin_idx,:);
    vs = [v1; v2; v3; v4];

    % diagonals
    d1 = v1 - v3;
    d2 = v2 - v4;

    dot(d1/norm(d1),d2/norm(d2)); % should be small

    theta = mod(pi/4 + atan(d1(2)/d1(1)), pi/2);

    % TODO problems when theta close to 0 (vertexes aliased)
    % 
    % maybe use this to fit a square
    % [k,av] = convhull(pc);
    % plot(pc(k,1),pc(k,2));
    %
    % or fit a square to the whole pc
end