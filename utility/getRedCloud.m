function pcR = getRedCloud(show)
%GETREDCLOUD Return the pointcloud of the red region
%   Inputs:
%       show: whether to plot the pointcloud
%   Outputs:
%       pcB: pointcloud of the red region
global Rmn Rmx;
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
    pause(3);
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
% the bounds of the Red region

pcR = pcrestrict(pcMerged.Location, Rmn, Rmx);

if show
    pcshow(pcR); hold on;
end
end

