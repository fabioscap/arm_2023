position1 = [0.35,0,0.4,-pi,0,0];
position2 = [0.42,-0.29,0.4,-pi,0,0];
position3 = [0.42,0.29,0.4,-pi,0,0];
position4 = [0.05,0.29,0.4,-pi,0,0];
position5 = [0.05,-0.29,0.4,-pi,0,0];

scanPositions = {position1,position2,position3,position4,position5};
ptClouds = {};
for i=1:length(scanPositions)
    moveTo(scanPositions{i});
    pause(5);
    ptCloud = getPointCloud;
    ptClouds{i} = ptCloud;
    if i == 1
        pcMerged = ptCloud;
    else
        mergeSize = 0.001;
        pcMerged = pcmerge(pcMerged, ptCloud, mergeSize);
    end
end
indx = find(pcMerged.Location(:,3) > -0.3);
pcMergedTop = select(pcMerged,indx);
pcshow(pcMergedTop);
% pcshow(pcMerged);
save("ptClouds.mat","ptClouds");