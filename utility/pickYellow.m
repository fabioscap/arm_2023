% those object in the yellow region are always 4.
num_objects = 4;
n_try = 0;
while num_objects>0 && n_try<3
    moveTo([0.2,0,0.4,-pi,0,0],5);
    [num_objects, centers, bboxes,scores, labels] = findObjects(net,[Ymn;Ymx],true);
    pause(1);
    if num_objects<=0
        close all;
        break
    end
    pcYellow= getYellowCloud(false);
    minIdxs = [];
    [labels, num] = pcsegdist(pointCloud(pcYellow),0.02);
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
    pcshow(pcYellow);
    hold on;
    
    for i=1:num
        moveTo(home,1);
        if i>num_objects
            break;
        end
        v_l = valid_labels(i);
        [pc, minIdx] = findClosestPC(centers(v_l,:),pcYellow,labels, minIdxs);
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

        [z_dir, approach_orientation] = findBestOrientation(type,[ctr,dir],pc,pcYellow);
        pickObject(type,[ctr,dir],z_dir,approach_orientation);
        throwAway(type);
    end
    n_try = n_try+1;
    close all;
end
moveTo(home,1);


