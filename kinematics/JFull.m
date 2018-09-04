function [ J ] = JFull( angles, arm, robot )
% Calculate Jacobian matrix
% @arm - string "L" or "R"
% @angles - angles array (6x1)
% @robot - constants for robot
% result - 6x6 matrix
%% Validate input arguments
validateattributes(angles,{'double','sym'},{'size',[6,1],'nonnan'});
validateattributes(arm,{'string','char'},{'size',[1,1]});
validateattributes(robot,{'struct'},{});

if arm == "R"
    b = -1;
elseif arm == "L"
    b = 1;
else
    b = 1;
    disp('Incorrect letter, calculate as "L" arm');
end
%%

T123 = rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;-b*robot.armAngle])* transH([0;b*robot.shoulderLength;0]) *...
    rotH([0;angles(2);0]) * rotH([angles(3);0;0]) * transH([0;b*robot.elbowHeight;0]);

T456 = rotH([0;angles(4);0])*rotH([0;0;angles(5)])*rotH([0;angles(6);0]);

X = T123 * T456 * transH([0;b*robot.wristLength;0]);

T0 = inv(X(1:3,1:3));
T0=[T0,zeros(3,1);0 0 0 1];


Td=Rzd(angles(1)) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;-b*robot.armAngle])* transH([0;b*robot.shoulderLength;0]) *...
    rotH([0;angles(2);0]) * rotH([angles(3);0;0]) * transH([0;b*robot.elbowHeight;0])...
    *T456*transH([robot.wristLength;0;0])*T0;
J1 = Jcol(Td);

Td=rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;-b*robot.armAngle])* transH([0;b*robot.shoulderLength;0]) *...
    Ryd(angles(2)) * rotH([angles(3);0;0]) * transH([0;b*robot.elbowHeight;0])...
    *T456*transH([robot.wristLength;0;0])*T0;
J2 = Jcol(Td);

Td=rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;-b*robot.armAngle])* transH([0;b*robot.shoulderLength;0]) *...
    rotH([0;angles(2);0]) * Rxd(angles(3)) * transH([0;b*robot.elbowHeight;0])...
    *T456*transH([robot.wristLength;0;0])*T0;
J3 = Jcol(Td);

Td=T123 * Ryd(angles(4))*rotH([0;0;angles(5)])*rotH([0;angles(6);0])...
    * transH([robot.wristLength;0;0])*T0;
J4 = Jcol(Td);

Td=T123 * rotH([0;angles(4);0])*Rzd(angles(5))*rotH([0;angles(6);0])...
    * transH([robot.wristLength;0;0])*T0;
J5 = Jcol(Td);

Td=T123 * rotH([0;angles(4);0])*rotH([0;0;angles(5)])*Ryd(angles(6))...
    * transH([robot.wristLength;0;0])*T0;
J6 = Jcol(Td);

J = [J1, J2, J3, J4, J5, J6];
end

