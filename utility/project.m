function [mask, idxes] = project(points, camera_transf)
%PROJECT return a binary mask of a point cloud as seen from camera
%position

% hard coded image dimensions
rows = 480;
cols = 640;

[K,~] = getCameraMatrix;

camera_transl = camera_transf.Transform.Translation;
camera_rotation = camera_transf.Transform.Rotation;
camera_quaternion = [camera_rotation.W, camera_rotation.X,...
camera_rotation.Y,camera_rotation.Z];
camera_translation = [camera_transl.X,...
camera_transl.Y,camera_transl.Z];
rotm = quat2rotm(camera_quaternion);
tform = rigidtform3d(rotm,camera_translation);
points3 = tform.transformPointsForward(points);

mask = false(rows, cols);
idxes = zeros(rows, cols);

fx = K(1,1);
fy = K(2,2);
cx = K(1,3);
cy = K(2,3);

for i=1:size(points3,1)
    p3 = points3(i,:)';
    
    p2 = [0;0];

    p2(1) = fx*p3(1)/p3(3) + cx;
    p2(2) = fy*p3(2)/p3(3) + cy;
    
    u = floor(p2(1));
    v = floor(p2(2));
    if (u < 1 || u > cols || v < 1 || v > rows )
        continue;
    end

    mask(v,u) = true;
    idxes(v,u) = i;
end

end