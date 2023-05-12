num_objects = 4;
unreachable = 0;
unreachable_coords = [];
n_try = 0;
while num_objects>unreachable && n_try<3
    moveTo([0.7,0.,0.4,-pi,0,0],5);
    [num_objects, centers, bboxes,scores, labels] = findObjects(net,[Rmn;Rmx],true);
    if num_objects<=unreachable
        break
    end
    pcRed = getRedCloud(false);
    minIdxs = [];
    [labels, num] = pcsegdist(pointCloud(pcRed),0.02);
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
    
    figure;
    pcshow(pcRed,'g');
    hold on;
    scatter3(centers(:,1),centers(:,2),centers(:,3),5,"white");
    
    for i=1:num
        moveTo(home+[0.3,0,-0.2,0,0,0],1);
        if i>num_objects
            break;
        end
        v_l = valid_labels(i);
        [pc, minIdx] = findClosestPC(centers(v_l,:),pcRed,labels, minIdxs);
        minIdxs = [minIdxs, minIdx];
        [type, obj, model_tf, ctr, dir, rmse]= classifyDepth(pc);
        dir = dir/5;
        plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
        quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3),'Color','white');
        if type == "bottle"
            pcshow(pc,"b"); hold on;
            offset = [0.015;0;0.01];
        elseif type == "can"
            pcshow(pc,"r"); hold on;
            offset = [0.015;0;0.0];
        end
        too_close = false;
        if ctr(1)>0.9
            for k=1:length(unreachable_coords)
                dist = norm(unreachable_coords(k,:)-ctr);
                if dist < 0.01
                    too_close = true;
                    break;
                end
            end
            if ~too_close
                unreachable = unreachable+1;
            end
        else
            [z_dir, approach_orientation] = findBestOrientation(type,[ctr,dir],pc,pcRed);
            pickObject(type,[ctr+offset,dir],z_dir,[-pi,pi/8,0]);
            throwAway(type);
        end
    end
    n_try = n_try+1;
end
moveTo(home,1);


