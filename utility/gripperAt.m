function gripperAt(width,effort)
    arguments
        width
        effort=20
    end
    global gripAct gripGoal
    gripperCommand = rosmessage(gripAct);
    gripperCommand.Command.MaxEffort = effort; %N
    gripperCommand.Command.Position = width/2; % this action client controls distance btw finger and center
    gripGoal.Command = gripperCommand.Command;
    %waitForServer(gripAct); % Can use this function if concerned with missed
    % goals but generally it should work correctly.
    sendGoal(gripAct,gripGoal)
end

