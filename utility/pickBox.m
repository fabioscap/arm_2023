num_objects = 5;

% if ~exist("pcBox", "var")
%     pcBox = filterBox(getBoxCloud(false));
% end
% if ~exist("detector", "var")
%     detector = load("../YOLO4/detector.mat").detector;
% end

photo_position = [0.43,-0.45,0.35,-pi,0,2*pi/5];
n_try = 0;
while num_objects>0 && n_try<3
    moveTo(photo_position);
    tftree_photo = rostf;
    pause(1);
    while isempty(tftree_photo.AvailableFrames)
        disp("Waiting for tftree");
        tftree_photo = rostf;
        pause(1);
    end
    transf_photo = getTransform(tftree_photo, 'panda_link0', 'panda_EE','Timeout',3); 
    [num_objects, centers, bboxes,scores, labels] = findObjects(net,[Bmn;Bmx],true);
    message = ['Found ',num2str(num_objects),' objects using YOLO.'];
    disp(message);
    pause(1);
    if num_objects<=0
        close all;
        break
    end
    pcBox_all = getBoxCloud(false);
    pcBox = filterBox(pcBox_all);
    minIdxs = [];
    [labels, num] = pcsegdist(pointCloud(pcBox),0.01);
    valid_labels = [];
    for j=1:num
        l = labels(labels==j);
        n_points = length(l);
        if n_points > 100
            valid_labels = [valid_labels, j];
        end
    end
    [labels, valid_labels] = fixSegmentation(pcBox, labels, valid_labels, num, bboxes, tftree_photo);
    message = ['Pointcloud was segmented in ',num2str(length(valid_labels)),' parts.'];
    disp(message);
    message = [num2str(length(valid_labels)),' parts have more than 100 points.'];
    disp(message);
    
    if num<=0
        break
    end

    figure
    pcshow(pcBox);
    hold on;

    for i=1:num
        moveTo(photo_position,1);
        if i>num_objects
            break;
        end
        v_l = valid_labels(i);
        [pc, minIdx] = findClosestPC(centers(v_l,:),pcBox,labels, minIdxs);
        minIdxs = [minIdxs, minIdx];
        [type, obj, model_tf, ctr, dir, rmse]= classifyDepth(pc);
        message = ['Object ',convertStringsToChars(type),' -> rmse: ',num2str(rmse)];
        disp(message);
        message = ['Distance from base of the robot is ',num2str(norm(ctr-[-0.1,0,0.615]))];
        disp(message);
        dir = dir/5;
        if type == "bottle"
            pcshow(pc,"b"); hold on;
        elseif type == "can"
            pcshow(pc,"r"); hold on;
        end
        plot3(ctr(1),ctr(2),ctr(3),'x','Color','white');
        quiver3(ctr(1),ctr(2),ctr(3),dir(1),dir(2),dir(3),'Color','white');

        [z_dir, approach_orientation] = findBestOrientation(type,[ctr,dir],pc,pcBox_all);
        pickObject(type,[ctr,dir],z_dir,approach_orientation);
        throwAway(type);
    end
    close all;
end
% 
% for i=1:n_objects
%     moveTo(photo_position);
% 
%     img = takePicture("None");
%     depth_img = takePicture("None", "depth");
%     [bboxes,confs,labels] = detect(detector,img);
% 
%     % get the highest confidence classification
%     [max_c, idx] = max(confs);
% 
%     bbox = bboxes(idx,:);
% 
%     % imshow(insertObjectAnnotation(img,"rectangle",bbox,labels(idx)));
% 
%     % bbox centroid in img coordinates
%     ctr_img = round([bbox(1) + bbox(3)/2; bbox(2) + bbox(4)/2]);
% 
%     % this is the point 
%     p_link0 = unproject(ctr_img, depth_img);
% 
%     pc = getPointCloud2();
%     pcshow(pc);hold on;
%     initGuess = rigidtform3d(eye(3), p_link0);
% 
%     [tf, pctf, rmse] = modelfit(pcBox,can_fit,initGuess);
%     rmse
% 
%     pcshow(pctf,"r")
% 
%     %pause()
% end