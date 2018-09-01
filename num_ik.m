function [allAngles] = num_ik(X, arm, robot)
%NUM_IK Summary of this function goes here
%   Detailed explanation goes here

angles = zeros(3,1);
if arm == "R"
    b = -1;
elseif arm == "L"
    b = 1;
else
    b = 1;
    disp('Incorrect letter, calculate as "L" arm');
end
pos = X(1:3);

%% Third angle (geometricaly)
q31=-acos(-(robot.shoulderLength^2 + robot.elbowHeight^2-norm(pos-[0 0 robot.bodyHeight]')^2)...
    /(2*robot.shoulderLength * robot.elbowHeight));

%% Second angle (from FK)
q21=acos(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(-q31)));
q24=acos(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(q31)));

%% First angle (geometricaly)
phi=acos((robot.bodyHeight-pos(3))/robot.elbowHeight);
[xout,yout] = circcirc(0,0,robot.shoulderLength,pos(1),pos(2),robot.elbowHeight*sin(phi));

q11=atan2(yout(2),xout(2))-pi/2;
q12=atan2(yout(1),xout(1))-pi/2;

allAngles=[q11 q12 q11 q12; q21 -q21 -q24 q24; q31 q31 -q31 -q31];
end