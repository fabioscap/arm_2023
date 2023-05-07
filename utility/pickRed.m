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
    pcRed = getRedCloud(true);
    minIdxs = [];
    [labels, num] = pcsegdist(pointCloud(pcRed),0.02);
    figure;
    pcshow(pcRed);
    hold on;
    scatter3(centers(:,1),centers(:,2),centers(:,3),5,"white");
    
    for i=1:num_objects
        moveTo(home+[0.3,0,-0.2,0,0,0],1);
        [pc, minIdx] = findClosestPC(centers(i,:),pcRed,labels, minIdxs);
        minIdxs = [minIdxs, minIdx];
        pcshow(pc,"red");
        [type, obj, model_tf, ctr, dir]= classifyDepth(pc);
        dir = dir/5;
        pcshow(obj,"r");
        plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
        quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3),'Color','white');
        % marco
        if type=="can"
            offset = [0.015;0;0.05];
        else
            offset = [0.015;0;0];
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
            pickObject(type,[ctr+offset,dir],[-pi,pi/8,0]);
            throwAway(type);
        end
    end
    n_try = n_try+1;
end
moveTo(home,1);


