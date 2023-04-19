function gripperAt(width)
    [gripAct,gripGoal] = rosactionclient('/franka_gripper/gripper_action');
    gripperCommand = rosmessage(gripAct);
    gripperCommand.Command.MaxEffort = 20; %N
    gripperCommand.Command.Position = width/2; % this action client controls distance btw finger and center
    gripGoal.Command = gripperCommand.Command;
    waitForServer(gripAct); % Can use this function if concerned with missed
    % goals but generally it should work correctly.
    sendGoal(gripAct,gripGoal)
end

