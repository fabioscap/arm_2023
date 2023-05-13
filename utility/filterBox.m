function [pcFiltered] = filterBox(pc)
%FILTERBOX Removes the points in the pointcloud not inside the box.
%   Inputs:
%       pc: pointcloud
%   Outputs:
%       pcFiltered: the resulting pointcloud

    % vertexes of the box
    vrt_x = [ 0.17,  0.685,  0.755,  0.26];
    vrt_y = [-0.415, -0.26, -0.55, -0.705];

    in_points = inpolygon(pc(:,1),pc(:,2), vrt_x, vrt_y);

    pcFiltered = pc(in_points,:);
end