%% Ideal Data
robot.bodyHeight = 0.185;
% robot.bodyHeight = 0.5;
robot.bodyEx = 0.300;
robot.bodyIn = 0.100;

robot.armAngle = deg2rad(10);
% robot.armAngle = 0;
robot.shoulderLength = 0.197;
robot.shoulderLength = 0.6;
robot.shoulderEx = 0.100;
robot.shoulderIn = 0.0900;

robot.elbowHeight = 0.233;
% robot.elbowHeight = 0.8;
robot.elbowEx = 0.100;
robot.elbowIn = 0.0900;

robot.wristLength = 0.378;
% robot.wristLength = 0;
robot.wristEx = 0.100;
robot.wristIn = 0.0900;

robot.Kactuator = [1e6;1e6;1e6;1e6;1e6;1e6];

robot.Ealum = 7E10;
robot.nuAL = 0.34;
robot.Kth = Kth(robot);

robot.Rtool = 0.1;
robot.shiftTool = 0.05;
robot.angleTool = deg2rad(120);


robot.maxAngle(1) = deg2rad(90);
robot.maxAngle(2) = deg2rad(105);
robot.maxAngle(3) = deg2rad(45);
robot.maxAngle(4) = deg2rad(90);
robot.maxAngle(5) = deg2rad(90);
robot.maxAngle(6) = deg2rad(90);

%% Real Data
robotReal.bodyHeight = 0.187;
robotReal.bodyEx = 0.301;
robotReal.bodyIn = 0.099;

robotReal.armAngle = deg2rad(11);
robotReal.shoulderLength = 0.196;
robotReal.shoulderEx = 0.101;
robotReal.shoulderIn = 0.0901;

robotReal.elbowHeight = 0.235;
robotReal.elbowEx = 0.099;
robotReal.elbowIn = 0.0899;

robotReal.wristLength = 0.380;
robotReal.wristEx = 0.100;
robotReal.wristIn = 0.0901;

robotReal.Kactuator = [1e6;1e6;1e6;1e6;1e6;1e6];

robotReal.Ealum = 7E10;
robotReal.nuAL = 0.34;
robotReal.Kth = Kth(robotReal);

robotReal.Rtool = 0.1;
robotReal.shiftTool = 0.05;
robotReal.angleTool = deg2rad(120);

robotReal.maxAngle(1) = deg2rad(90);
robotReal.maxAngle(2) = deg2rad(105);
robotReal.maxAngle(3) = deg2rad(45);
robotReal.maxAngle(4) = deg2rad(90);
robotReal.maxAngle(5) = deg2rad(90);
robotReal.maxAngle(6) = deg2rad(90);

sampleConf = [];
for i = 1:9
    sampleConf = [sampleConf; randi(90)...
        randi(105) randi(45)...
        randi(90) randi(90)...
        randi(90)];
    
end
sampleConf = deg2rad(sampleConf);