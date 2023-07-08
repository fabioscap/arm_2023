function [done,eePosition,eeQuaternion] = moveTo(position,min_delay,noStop,fix,max_steps)
%MOVETO Move the end-effector to a taregt position
%   Inputs:
%       position: 6-dimensional vector containing target position and orientation
%       of the end-effector
%       min_delay: if the robot does not reach the target how long to wait
%       before exiting
%       noStop: if true the function ends after min_delay seconds
%       fix: if true the robot, after stopping, updates the goal with the
%       difference between the target position and the reached position
%       max_steps: how many fixing steps to perform if fix is true
%   Outputs:
%       done: true if target position was reached
%       eePosition: position reached by the end-effector
%       eeQuaternion: orientation reached by the end-effector
    arguments
        position = [0.4,0,0.4,-pi,0,0];
        min_delay = 10;
        noStop = false;
        fix = false;
        max_steps = 3;
    end
    jointMess = rosmessage("geometry_msgs/PoseStamped");
    global jointPub;
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
    tftree = rostf;
    while isempty(tftree.AvailableFrames)
        disp("Waiting for tftree");
        tftree = rostf;
        pause(1);
    end
    transf = getTransform(tftree, 'panda_link0', 'panda_EE','Timeout',3); 
    transl = transf.Transform.Translation;
    rotation = transf.Transform.Rotation;
    eePosition = [transl.X,transl.Y,transl.Z];
    eeQuaternion = [rotation.W, rotation.X,rotation.Y,rotation.Z];
    startTime = tic();
    nsteps = 0;
    if noStop
        pause(min_delay);
        done = 0;
    else
        while true
            tftree = rostf;
            cartesianError = norm(eePosition-gripperGoal);
            orientationError = norm(eeQuaternion-quat);
            if cartesianError < 0.005
                if orientationError < 0.015
                    done = 1;
                    break;
                end
            end
            eePositionPrevious = eePosition;
            eeQuaternionPrevious = eeQuaternion;
            pause(0.5);
            transf = getTransform(tftree, 'panda_link0', 'panda_EE','Timeout',inf); 
            transl = transf.Transform.Translation;
            rotation = transf.Transform.Rotation;
            eePosition = [transl.X,transl.Y,transl.Z];
            eeQuaternion = [rotation.W, rotation.X,rotation.Y,rotation.Z];
            elapsedTime = toc(startTime);
            if norm(eePositionPrevious-eePosition)<0.01 && norm(eeQuaternionPrevious-eeQuaternion)<0.01 && elapsedTime>min_delay
                if nsteps == max_steps
                    done = 0;
                    break;
                elseif fix
                    deltaPos = (gripperGoal-eePosition)/2;
                    deltaOr = (quat-eeQuaternion)/2;
                    jointMess.Pose.Position.X = position(1)+deltaPos(1);
                    jointMess.Pose.Position.Y = position(2)+deltaPos(2);
                    jointMess.Pose.Position.Z = position(3)+deltaPos(3);
                    jointMess.Pose.Orientation.W = quat(1)+deltaOr(1);
                    jointMess.Pose.Orientation.X = quat(2)+deltaOr(2);
                    jointMess.Pose.Orientation.Y = quat(3)+deltaOr(3);
                    jointMess.Pose.Orientation.Z = quat(4)+deltaOr(4);
                    send(jointPub,jointMess);
                    nsteps = nsteps+1;
                    pause(1)
                else
                    done = 0;
                    break;
                end
            end
        end
    end
end

