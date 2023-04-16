function moveGripper(position,effort)
%MOVEGRIPPER Summary of this function goes here
%   Detailed explanation goes here

persistent gripAct gripGoal gripperCommand

if isempty(gripAct) || ~isvalid(gripAct)
     pause(1);
    [gripAct,gripGoal] = rosactionclient('/franka_gripper/gripper_action');
    gripperCommand = rosmessage(gripAct);
     pause(3);
end
% Activate gripper
%pause(1);
gripperCommand.Command.Position = position; % 0.04 fully open, 0 fully closed
gripperCommand.Command.MaxEffort = effort;
gripGoal.Command = gripperCommand.Command;            
%pause(1);
%disp(gripAct)
% Send command
sendGoal(gripAct,gripGoal);
end

