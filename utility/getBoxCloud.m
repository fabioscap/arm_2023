function pcB = getBoxCloud(show)
position1 = [0.75,-0.3,0.35,-pi,-pi/3,2*pi/5];
position2 = [0.5,-0.45,0.4,-pi,0,2*pi/5];
position3 = [0.40,-0.40,0.4,-pi,0,2*pi/5];
position4 = [0.30,-0.35,0.4,-pi,0,2*pi/5];

scanPositions = {position1,position2,position3,position4};%,position5};
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
% save the full point_cloud just in case
save("ptClouds.mat","ptClouds");
mn = [-10,-10,-0.079];
mx = [10,10,10-0.615];
pcB = pcrestrict(pcMerged.Location, mn, mx);

if show
    pcshow(pcB,"g"); hold on;
end
end