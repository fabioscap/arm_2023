function ptCloudWorld = getPointCloud()
%GETPOINTCLOUD Summary of this function goes here
%   Detailed explanation goes here
    tftree = rostf; %finds TransformationTree directly from ros
    pause(1);
    camera_transf = getTransform(tftree, 'panda_link0', 'panda_EE');
    camera_transf2 = getTransform(tftree, 'panda_link0', 'camera_link');        
    camera_transl = camera_transf2.Transform.Translation;
    camera_rotation = camera_transf.Transform.Rotation;
    camera_quaternion = [camera_rotation.W, camera_rotation.X,...
        camera_rotation.Y,camera_rotation.Z];
    camera_translation = [camera_transl.X,...
        camera_transl.Y,camera_transl.Z];
    quat = camera_quaternion;
    rotm = quat2rotm(quat);
    fixedRotation = eul2rotm([0 0 pi],"XYZ"); % fixed rotation between gazebo camera and camera link
%     fixedRotation = eul2rotm([-pi -pi/2 0],"XYZ");
    rotm = rotm*fixedRotation' ;
    translVect = camera_translation;
    tform = rigid3d(rotm,[translVect(1),translVect(2),translVect(3)]);
    % tform = rigid3d(rotm,[0, 0, 0]);
    
    pointCloudSub = rossubscriber('/camera/depth/points');
    pointcloud = receive(pointCloudSub);
    xyz = readXYZ(pointcloud);
    xyz(:,[1 2]) = xyz(:,[2 1]);
    xyz(:,2) = -xyz(:,2);
    xyz(:,3) = xyz(:,3)+0.05;
    
    % Remove NaNs
    xyzLess = double(rmmissing(xyz));
    % Create point cloud object
    ptCloud = pointCloud(xyzLess);
    % Transform point cloud to world frame
    ptCloudWorld = pctransform(ptCloud,tform);
end

