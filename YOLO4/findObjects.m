function [num_objects, centers, bboxes,scores,labels] = findObjects(net, bounds, show)
%FINDOBJECTS Using a network for object detection finds the objects in an image and their coordinates
%in the world. Only looks for objects labelled as "bottle" or "can".
%   Inputs:
%       net: the network used for object detection
%       bounds: the bounds, in world coordinates, in which to find the 
%       objects
%       show: whether to show the picture with the found bounding boxes
%   Outputs:
%       num_objects: the number of valid objects found
%       centers: the centers of the found objects in world coordinates
%       bboxes: the found bounding boxes
%       scores: the network scores for the found objects
%       labels: the types of objects found. Either "bottel" or "can"
I = takePicture("None","rgb");
Id = takePicture("None","depth");
[bboxes,scores,labels] = detect(net,I);
bboxes = bboxes(labels~="pouch",:);
scores = scores(labels~="pouch");
labels = labels(labels~="pouch");

remove_idx = ones(size(labels));
for i=1:size(labels)
    for j=i+1:size(labels)
        if remove_idx(j)~=0 && remove_idx(i)~=0
            overlapRatio = bboxOverlapRatio(bboxes(i,:),bboxes(j,:),"Min");
            if overlapRatio > 0.1
                if scores(i)>scores(j)
                    remove_idx(j) = 0;
                else
                    remove_idx(i) = 0;
                end
            end
        end
    end
end
bboxes = bboxes(remove_idx==1,:);
scores = scores(remove_idx==1);
labels = labels(remove_idx==1);
if size(labels)~=0
    picture_centers = [round(bboxes(:,1)+bboxes(:,3)/2) round(bboxes(:,2)+bboxes(:,4)/2)];
    centers = unproject(picture_centers,Id);
    in = inpolygon(centers(:,1),centers(:,2),[bounds(1,1),bounds(2,1),bounds(2,1),bounds(1,1)],[bounds(1,2),bounds(1,2),bounds(2,2),bounds(2,2)]);
    centers = centers(in,:);
    centers_size = size(centers);
    num_objects = centers_size(1);
else
    num_objects = 0;
    centers = [];
end
if show
    figure;
    I = insertObjectAnnotation(I,"rectangle",bboxes,labels);
    imshow(I);
end

end