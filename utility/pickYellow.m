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
%pcshow(pcYellow);
hold on;

% does not work in ARM1.txt (fabio)
%[labels, ctrs] = kmeans(pcYellow, num_objects,'Start',C);

[labels, num] = pcsegdist(pointCloud(pcYellow),0.05);
if num ~= num_objects
    disp("errore nel clustering")
end

colors = ["r", "g","b","magenta"];

for i=1:num_objects
    %moveGripper(0.04,10);
    pc = pcYellow(labels==i,:);
    %pcshow(pc, colors(i)); hold on;
    % put all this in a function?
    [type, obj, model_tf, ctr, dir]= classifyDepth(pc);
    disp(type);
    dir = dir/5;
    if type == "bottle"
        pcshow(obj,"r"); hold on;
    elseif type == "can"
        pcshow(obj,"b"); hold on;
    end
    plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
    quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3));
    % marco
    pickObject(type,[ctr,dir]);
    throwAway(type);
    moveTo(home,1);
end



