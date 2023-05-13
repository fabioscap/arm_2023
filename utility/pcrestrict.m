function [xyz_restricted] = pcrestrict(xyz,mn,mx)
%PCRESTRICT restrics the points of a pointcloud to a region
%   Inputs:
%       xyz: n x 3-dimensional coordinates of the points of a pointcloud
%       mn: lower bound for the coordinates of the points
%       mx: upperbound for the coordinates of the points
%   Outputs:
%       xyz_restricted: n x 3-dimensional vector of the points inside the
%       bounds
    xyz_restricted = xyz(xyz(:,1)>=mn(1) & xyz(:,2)>=mn(2) & xyz(:,3)>=mn(3) &...
                         xyz(:,1)<=mx(1) & xyz(:,2)<=mx(2) & xyz(:,3)<=mx(3)  ...
                        ,:);

end

