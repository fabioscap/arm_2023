% TODO find better positions

position1 = [0.4,0,0.4,-pi,0,0];
position2 = [0.2,0,0.4,-pi,0,0];
position3 = [0.31,-0.31,0.24,-2.5,-0.34,0.6];
position4 = [0.564, 0.112, 0.204,-2.930, -0.725, 3.08];
position5 = [0.25,-0.3,0.4,-pi,0,0];

scanPositions = {position1,position2,position3,position4,position5};
ptClouds = {};

% those object in the yellow region are always 4.
num_objects = 4;

% initial guess for centroids (necessary?)
C = [0.3025    0.1378    0.6396;
    0.2479   -0.2240    0.5707;
    0.0857    0.2156    0.6220;
    0.2255   -0.0305    0.5658];
if ~exist("pcYellow", "var")
    for i=1:length(scanPositions)
        moveTo(scanPositions{i})
        pause(10);
        ptCloud = getPointCloud2;
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
else
    disp("skipping photos")
end
% the bounds of the yellow region (world frame)
% TODO maybe move this in link0 frame?
mn = [0,-0.3,0.52];
mx = [0.35,0.27,10];

pcYellow = pcrestrict(pcMerged.Location, mn, mx);
% TODO maybe downsample the point clouds? we have 60k points

labels = kmeans(pcYellow, num_objects);

for i=1:num_objects
    obj = pcYellow(labels==i,:);
    
    class = classifyDepth(obj);
    
    hold on
    if (class == 0)
        pcshow(obj,"r");
    else
        pcshow(obj,"b");
    end
end
