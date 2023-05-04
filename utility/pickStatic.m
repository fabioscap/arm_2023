home = [0.4,0,0.4,-pi,0,0];
canHeight = 3.54*0.033;
bottleHeight = 5.8*0.034;
bottleWidth = 2*0.034;
robotOffset = [0.1,0,-0.615,0,0,0];

can1Gazebo = [-0.082,-0.668,0.691,0,0,1];
can2Gazebo = [-0.081,-0.670,0.573,0,0,1];
can3Gazebo = [-0.107,0.369,0.67,0,0,1];
can4Gazebo = [0.30,0.5105,0.573,0,0,1];
bottle1Gazebo = [-0.170,-0.464,0.615-0.095,0,0,1];
bottle2Gazebo = [-0.143,0.527,0.515,1,0,0];
bottle3Gazebo = [0.220,0.634,0.526,1,0,0];

can1Centered = can1Gazebo + [[0,0,canHeight/2],0,0,0];
can2Centered = can2Gazebo + [[0,0,canHeight/2],0,0,0];
can3Centered = can3Gazebo + [[0,0,canHeight/2],0,0,0];
can4Centered = can4Gazebo + [[0,0,canHeight/2],0,0,0];
bottle1Centered = bottle1Gazebo + [[0,0,bottleHeight/2],0,0,0];
bottle2Centered = bottle2Gazebo + [[0,0,bottleWidth/2],0,0,0];
bottle3Centered = bottle3Gazebo + [[0,0,bottleWidth/2],0,0,0];
can1 = can1Centered+robotOffset;
can2 = can2Centered+robotOffset;
can3 = can3Centered+robotOffset;
can4 = can4Centered+robotOffset;
bottle1 = bottle1Centered+robotOffset;
bottle2 = bottle2Centered+robotOffset;
bottle3 = bottle3Centered+robotOffset;

clear('can*Gazebo');
clear('bottle*Gazebo');
clear('can*Centered');
clear('bottle*Centered');

% startROS;
pickObject('can',can1);
throwAway('can');
moveTo(home,0);
pickObject('can',can2);
throwAway('can');
moveTo(home,0);
pickObject('can',can3);
throwAway('can');
moveTo(home,0);
pickObject('can',can4);
throwAway('can');
moveTo(home,0);
pickObject('bottle',bottle1);
throwAway('bottle');
moveTo(home,0);
%This is needed to avoid one of the boxes
moveTo([0.0,0.6,0.3,-pi,0,0],0);
pickObject('bottle',bottle2,[-pi-pi/10,0,0]);
throwAway('bottle');
moveTo(home,0);
%This is needed to avoid one of the boxes
moveTo([0.3,0.6,0.3,-pi,0,0],0);
pickObject('bottle',bottle3);
throwAway('bottle');
moveTo(home,0);