function moveGripper(position,effort)
%MOVEGRIPPER Summary of this function goes here
%   Detailed explanation goes here

persistent gripAct gripGoal gripperCommand

if isempty(gripAct) || ~isvalid(gripAct)
    pause(1);
    [gripAct,gripGoal] = rosactionclient('/franka_gripper/gripper_action');
    gripperCommand = rosmessage(gripAct);
    pause(3);
    gripAct.ActivationFcn = @(~)NOP;
    gripAct.FeedbackFcn = @(~,msg)NOP;
    gripAct.ResultFcn = [];
end
% Activate gripper
%pause(1);
gripperCommand.Command.Position = position; % 0.04 fully open, 0 fully closed
gripperCommand.Command.MaxEffort = effort;
gripGoal.Command = gripperCommand.Command;            
%pause(1);
% Send command
% i = 0;
% while i<5
%     [result,state,status] = sendGoalAndWait(gripAct,gripGoal,5);
%     if state == 'succeeded'
%         break;
%     end
%     i = i+1;
% end
sendGoal(gripAct,gripGoal);
pause(3);
end

function NOP(varargin)
%NOP Do nothing
%
% NOP( ... )
%
% A do-nothing function for use as a placeholder when working with callbacks
% or function handles.

% Intentionally does nothing
end