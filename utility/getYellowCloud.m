function pcY= getYellowCloud(show)
%GE Summary of this function goes here
%   Detailed explanation goes here
global Ymn Ymx;
position1 = [0.2,0.2,0.4,-pi,0,0];
position2 = [0.2,-0.2,0.4,-pi,0,0];
position3 = [0.31,-0.3,0.3,-2.5,-0.34,0.];
position4 = [0.56, 0, 0.3,-pi, -pi/4, 0];
position5 = [0.31,0.3,0.3,2.5,-0.34,0.];

scanPositions = {position1,position2,position3,position4,position5};
ptClouds = {};
for i=1:length(scanPositions)
    moveTo(scanPositions{i},5);
    pause(2);
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
%pcshow(pcMerged);
% save the full point_cloud just in case
save("ptClouds.mat","ptClouds");
% the bounds of the yellow region
pcY = pcrestrict(pcMerged.Location, Ymn, Ymx);

moveTo([0.2,0,0.4,-pi,0,0]);

if show
    pcshow(pcY,"g"); hold on;
end
end

