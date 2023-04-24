function pcY= getYellowCloud(show)
%GE Summary of this function goes here
%   Detailed explanation goes here
% TODO find better positions
position1 = [0.4,0,0.4,-pi,0,0];
position2 = [0.2,0,0.4,-pi,0,0];
position3 = [0.31,-0.31,0.24,-2.5,-0.34,0.6];
position4 = [0.564, 0.112, 0.204,-2.930, -0.725, 3.08];
position5 = [0.25,-0.3,0.4,-pi,0,0];

scanPositions = {position1,position2,position3,position4,position5};
ptClouds = {};
for i=1:length(scanPositions)
    moveTo(scanPositions{i});
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
pcshow(pcMerged);
% save the full point_cloud just in case
save("ptClouds.mat","ptClouds");
% the bounds of the yellow region link0 frame
mn = [0+0.1,-0.3,0.52-0.615];
mx = [0.35+0.1,0.27,10-0.615];
pcY = pcrestrict(pcMerged.Location, mn, mx);

if show
    pcshow(pcY,"g"); hold on;
end
end

