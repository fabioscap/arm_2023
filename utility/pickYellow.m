startROS;
poses;
% those object in the yellow region are always 4.
num_objects = 4;

% initial guess for centroids (necessary?)
C = [0.3025    0.1378    0.6396;
    0.2479   -0.2240    0.5707;
    0.0857    0.2156    0.6220;
    0.2255   -0.0305    0.5658];
if ~exist("pcYellow", "var")
    pcYellow = getYellowCloud(true);
end
pcshow(pcYellow);
hold on;

[labels, ctrs] = kmeans(pcYellow, num_objects,'Start',C);

for i=1:num_objects
    %moveGripper(0.04,10);
    pc = pcYellow(labels==i,:);

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



