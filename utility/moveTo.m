function [done,eePosition,eeQuaternion] = moveTo(position,min_delay)
%MOVETO Summary of this function goes here
%   Detailed explanation goes here
    arguments
        position = [0.4,0,0.4,-pi,0,0];
        min_delay= 10;
    end
    jointMess = rosmessage("geometry_msgs/PoseStamped");
    jointPub = rospublisher("/cartesian_impedance_example_controller/equilibrium_pose");
    pause(1);
    
    % start 0.35,0.0001,0.5
    gripperGoal = position(1:3);
    gripperRotationX = position(4); % radians
    gripperRotationY = position(5); % radians
    gripperRotationZ = position(6); % radians
    
    jointMess.Pose.Position.X = position(1);
    jointMess.Pose.Position.Y = position(2);
    jointMess.Pose.Position.Z = position(3);
    quat = angle2quat(gripperRotationX, gripperRotationY, gripperRotationZ, "XYZ");
    jointMess.Pose.Orientation.W = quat(1);
    jointMess.Pose.Orientation.X = quat(2);
    jointMess.Pose.Orientation.Y = quat(3);
    jointMess.Pose.Orientation.Z = quat(4);
    send(jointPub,jointMess);

    tftree = rostf; %finds TransformationTree directly from ros
    pause(1);
    transf = getTransform(tftree, 'panda_link0', 'panda_EE'); 
    transl = transf.Transform.Translation;
    rotation = transf.Transform.Rotation;
    eePosition = [transl.X,transl.Y,transl.Z];
    eeQuaternion = [rotation.W, rotation.X,rotation.Y,rotation.Z];
    startTime = tic();
    while true
        cartesianError = norm(eePosition-gripperGoal);
        orientationError = norm(eeQuaternion-quat);
        if cartesianError < 0.01
            if orientationError < 0.03
                done = 1;
                break;
            end
        end
        eePositionPrevious = eePosition;
        eeQuaternionPrevious = eeQuaternion;
        pause(1);
        transf = getTransform(tftree, 'panda_link0', 'panda_EE'); 
        transl = transf.Transform.Translation;
        rotation = transf.Transform.Rotation;
        eePosition = [transl.X,transl.Y,transl.Z];
        eeQuaternion = [rotation.W, rotation.X,rotation.Y,rotation.Z];
        elapsedTime = toc(startTime);
        if norm(eePositionPrevious-eePosition)<0.01 && norm(eeQuaternionPrevious-eeQuaternion)<0.01 && elapsedTime>min_delay
            done = 0;
            break;
        end
    end
end

