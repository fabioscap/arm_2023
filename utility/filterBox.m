function [pcFiltered] = filterBox(pc)
    % remove the box from the point cloud

    % vertexes of the box
    vrt_x = [ 0.17,  0.68,  0.76,  0.26];
    vrt_y = [-0.42, -0.26, -0.55, -0.71];

    in_points = inpolygon(pc(:,1),pc(:,2), vrt_x, vrt_y);

    pcFiltered = pc(in_points,:);
end