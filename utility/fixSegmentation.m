function [labels, valid_labels] = fixSegmentation(pc, labels, valid_labels, num, bboxes, transform_photo)
%FIXSEGMENTATION Summary of this function goes here
%   Detailed explanation goes here
to_remove = [];
for i=1:num
    new_label = 10000;
    v_l = valid_labels(i);
    [mask, mask_idx] = project(pc(labels==v_l,:), transform_photo);
    intersected_boxes = {};
    ib = 1;
    for b=1:size(bboxes,1)
        intersection = getIntersection(bboxes(b,:),mask);
        if intersection>0.1
            intersected_boxes{ib} = b;
            ib = ib + 1;
        end
    end
    if length(intersected_boxes) > 1
        to_remove = [to_remove, i];
        for b=1:length(intersected_boxes)
            bbox_labels = getIdxsInside(mask_idx, bboxes(intersected_boxes{b},:));
            current_label = 1;
            for l=1:length(labels)
                if labels(l)==v_l || (labels(l)>new_label*i-1 && labels(l)<new_label*(i+1))
                    if sum(ismember(current_label,bbox_labels))>0
                        labels(l) = new_label*i;
                    end
                    current_label = current_label+1;
                end
            end
            valid_labels = [valid_labels, new_label*i];
            new_label = new_label + 1;
        end
    end
end
for i=1:length(to_remove)
    valid_labels(to_remove(i)) = [];
end
end

function intersection = getIntersection(bbox, mask)
    bbox_mask = zeros(480,640);
    bbox_mask(floor(bbox(2)):floor(bbox(2)+bbox(4)),floor(bbox(1)):floor(bbox(1)+bbox(3))) = 1;
    overlap = bbox_mask.*mask;
    overlap_area = sum(sum(overlap));
    intersection = overlap_area/(bbox(3)*bbox(4));
end

function idxs = getIdxsInside(mask_idx,bbox)
    idxs = mask_idx(floor(bbox(2)):floor(bbox(2)+bbox(4)),floor(bbox(1)):floor(bbox(1)+bbox(3)));
    idxs(idxs==0) = [];
    idxs = reshape(idxs,[],1);
end