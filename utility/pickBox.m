n_objects = 5;

if ~exist("pcBox", "var")
    pcBox = filterBox(getBoxCloud(false));
end
if ~exist("detector", "var")
    detector = load("../YOLO4/detector.mat").detector;
end

photo_position = [0.43,-0.45,0.35,-pi,0,2*pi/5];

for i=1:n_objects
    moveTo(photo_position);

    img = takePicture("None");
    depth_img = takePicture("None", "depth");
    [bboxes,confs,labels] = detect(detector,img);

    % get the highest confidence classification
    [max_c, idx] = max(confs);
    
    bbox = bboxes(idx,:);

    % imshow(insertObjectAnnotation(img,"rectangle",bbox,labels(idx)));
       
    % bbox centroid in img coordinates
    ctr_img = round([bbox(1) + bbox(3)/2; bbox(2) + bbox(4)/2]);
    
    % this is the point 
    p_link0 = unproject(ctr_img, depth_img);

    pc = getPointCloud2();
    pcshow(pc);hold on;
    initGuess = rigidtform3d(eye(3), p_link0);

    [tf, pctf, rmse] = modelfit(pcBox,can_fit,initGuess);
    rmse

    pcshow(pctf,"r")

    %pause()
end