function [pcClosest,minIdx] = findClosestPC(center,pcRegion, labels, oldIdxs)
%FINDCLOSESTPC Summary of this function goes here
%   Detailed explanation goes here
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

