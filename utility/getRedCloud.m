function pcR = getRedCloud(show)
%GE Summary of this function goes here
%   Detailed explanation goes here
% TODO find better positions
position1 = [0.5,-0.3,0.4,-pi+pi/6,0,0];
position2 = [0.7,-0.3,0.4,-pi+pi/6,0,0];
position3 = [0.7,0.3,0.4,-pi-pi/6,0,0];
position4 = [0.5,0.3,0.4,-pi-pi/6,0,0];
position5 = [0.5,0,0.3,-pi,pi/4,0];
% position6 = [0.8,0,0.3,-pi,-pi/8,0];

scanPositions = {position1,position2,position3,position4,position5};
ptClouds = {};
for i=1:length(scanPositions)
    moveTo(scanPositions{i},2);
    ptCloud = getPointCloud;
    ptClouds{i} = ptCloud;
    if i == 1
        pcMerged = ptCloud;
    else
        mergeSize = 0.001;
        pcMerged = pcmerge(pcMerged, ptCloud, mergeSize);
    end
end
%indx = find(pcMerged.Location(:,3) > -0.3);
%pcMergedTop = select(pcMerged,indx);
% pcshow(pcMerged);
% save the full point_cloud just in case
save("ptClouds2.mat","ptClouds");
% the bounds of the yellow region link0 frame
mn = [0.65,-0.21,0.52-0.615];
mx = [1,0.25,10-0.615];
pcR = pcrestrict(pcMerged.Location, mn, mx);

if show
    pcshow(pcR); hold on;
end
end

