% those object in the yellow region are always 4.
num_objects = 4;
n_try = 0;
while num_objects>0 && n_try<3
    moveTo([0.2,0,0.4,-pi,0,0],5);
    [num_objects, centers, bboxes,scores, labels] = findObjects(net,[Ymn;Ymx],true);
    if num_objects<=0
        break
    end
    pcYellow= getYellowCloud(false);
    minIdxs = [];
    [labels, num] = pcsegdist(pointCloud(pcYellow),0.02);
    
    figure
    pcshow(pcYellow);
    hold on;
    
    colors = ["r", "g","b","magenta"];
    
    for i=1:num_objects
        moveTo(home,1);
        %moveGripper(0.04,10);
        [pc, minIdx] = findClosestPC(centers(i,:),pcYellow,labels, minIdxs);
        minIdxs = [minIdxs, minIdx];
        pcshow(pc,"red");
        [type, obj, model_tf, ctr, dir]= classifyDepth(pc);
        dir = dir/5;
        if type == "bottle"
            pcshow(obj,"r"); hold on;
        elseif type == "can"
            pcshow(obj,"b"); hold on;
        end
        plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
        quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3),'Color','white');
        % marco
        [z_dir, approach_orientation] = findBestOrientation(type,[ctr,dir],pc,pcYellow);
        pickObject(type,[ctr,dir],z_dir,approach_orientation);
        throwAway(type);
    end
    n_try = n_try+1;
end
moveTo(home,1);


