function [pcClosest,minIdx] = findClosestPC(center,pcRegion, labels, oldIdxs)
%FINDCLOSESTPC From a segmented pointcloud finds the group of points
%closest to the selected center
%   Inputs:
%       center: a 3-dimensional vector of the center
%       pcRegion: pointcloud containing all the segmented objects
%       labels: the labels corresponding to the different objects in the
%       pointcloud
%       oldIdx: the labels that need to be skipped
%   Outputs:
%       pcClosest: the pointcloud of the closest object to the center
%       minIdx: the corresponding label
    minDist = inf;
    minIdx = 0;
    n_groups = max(labels);
    for j=1:n_groups
        if ~any(oldIdxs==j)
            pc = pcRegion(labels==j,:);
            pcCenter = mean(pc);
            dist = norm(center-pcCenter);
            if dist < minDist
                minDist = dist;
                minIdx = j;
            end
        end
    end
    pcClosest = pcRegion(labels==minIdx,:);
end

