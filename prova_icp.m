% To run the program the correct IP address needs to the set.
rosIP = "192.168.0.43"; % IP address of ROS enabled machine 

% add all folders in the project to the path
if false
    addpath(genpath(pwd));
    startROS;
    initialization;
end

moveTo(home+[0.1,0,0,0,0,0]);

% pcYellow= getYellowCloud(false);
ptCloud = getPointCloud;
Ymn(3) = -1;
ptCloud = pcrestrict(ptCloud.Location, Ymn, Ymx);

minIdxs = [];
[labels, num] = pcsegdist(pointCloud(ptCloud),0.02);
valid_labels = [];
for j=1:num
    l = labels(labels==j);
    n_points = length(l);
    if n_points > 100
        valid_labels = [valid_labels, j];
    end
end
message = ['Pointcloud was segmented in ',num2str(num),' parts.'];
disp(message);
message = [num2str(length(valid_labels)),' parts have more than 100 points.'];
disp(message);

figure
pcshow(ptCloud);
hold on;

for i=1:num
    v_l = valid_labels(i);
    [pc, minIdx] = findClosestPC([0;0;0],ptCloud,labels, minIdxs);
    minIdxs = [minIdxs, minIdx];
    [type, obj, model_tf, ctr, dir, rmse]= classifyDepth(pc);
    dir = dir/5;
    if type == "bottle"
        pcshow(pc,"b"); hold on;
    elseif type == "can"
        pcshow(pc,"r"); hold on;
    end
    plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
    quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3),'Color','white');
end