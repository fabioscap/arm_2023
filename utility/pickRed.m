startROS;
poses;
% those object in the yellow region are always 4.
num_objects = 4;

% initial guess for centroids (necessary?)
if ~exist("pcRed", "var")
    pcRed = getRedCloud(true);
end
pcshow(pcRed);
hold on;

labels = pcsegdist(pointCloud(pcRed),0.01);
obj_idx = [1,2,3,6];

for i=2:num_objects
    %moveGripper(0.04,10);
    
    pc = pcRed(labels==obj_idx(i),:);

    % put all this in a function?
    [type, obj, model_tf, ctr, dir]= classifyDepth(pc);
    dir = dir/5;
    pcshow(obj,"r");
    plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
    quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3));
    % marco
    pickObject(type,[ctr,dir]);
    throwAway(type);
    moveTo(home);
end



