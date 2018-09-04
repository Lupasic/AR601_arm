function [ X, pos, eulAngle ] = FK3links( angles, arm, robot )
% Calculate forward kinematics for arm
% @arm - string "L" or "R"
% @angles - angles array (6x1)
% @robot - constants for robot
% @symb - if 1 - calc symb value
% result(1) - (4x4) result matrix
% result(2) - (3x1) position, which were extracted from result(1)
% result(3) - (3x1) Euler angles (ZYX), which were extracted from result(1)

%% Validate input arguments
if isnan(angles)
    disp ("Expected input to be non-NaN");
    return
end
validateattributes(angles,{'double','sym'},{'size',[3,1]});
validateattributes(arm,{'string','char'},{'size',[1,1]});
validateattributes(robot,{'struct'},{});

AllSymb = syms;


if isempty(AllSymb)
    if arm == "R"
        b = -1;
    elseif arm == "L"
        b = 1;
    else
        b = 1;
        disp('Incorrect letter, calculate as "L" arm');
    end
else
    syms b real;
end

T123 = rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;-b*robot.armAngle]) * rotH([0;angles(2);0]) *...
    transH([0;b*robot.shoulderLength;0]) * rotH([angles(3);0;0]) *...
    transH([0;b*robot.elbowHeight;0]);

X = T123;
pos = X(1:3,4);

if isempty(AllSymb)
    eulAngle = rotm2eul(X(1:3,1:3),'ZYX')';
else
    eulAngle = [];
end

end

