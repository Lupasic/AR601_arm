clear
% constants;

angles = sym('q',[3,1],'real');
robot.bodyHeight = sym('L1','real');

robot.armAngle = sym('qConst','real');
robot.shoulderLength = sym('L2','real');

robot.elbowHeight = sym('L3','real');

robot.wristLength = sym('L4','real');



%% Both arms
syms b real;

syms Xe Ye Ze real;

T123 = rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
    rotH([0;0;robot.armAngle]) * rotH([0;angles(2);0])...
    * transH([0;-b*robot.shoulderLength;0]) * rotH([angles(3);0;0])...
    * transH([0;0;-robot.elbowHeight]);
T123 = simplify(T123);

eqn_sys = T123(1:3,4);
eqn_sys(1) = eqn_sys(1) == Xe;
eqn_sys(2) = eqn_sys(2) == Ye;
eqn_sys(3) = eqn_sys(3) == Ze;

eqn_sys

%first angle can be solved geometricaly

AB = sqrt((Xe-0)^2 + (Ye-0)^2 + (Ze-robot.bodyHeight)^2);
angles(3) = deg2rad(180) - ...
    acos((robot.shoulderLength^2 + robot.elbowHeight^2 - AB^2)...
    / (2*robot.shoulderLength * robot.elbowHeight))

angles(2) = acos((robot.bodyHeight - Ze)/(robot.elbowHeight * cos(angles(3))))

% eqn = subs(eqn_sys(1),[str2sym('q2'),str2sym('q3')],[angles(2),angles(3)]);
eqn = eqn_sys(1);

S = solve(eqn,[angles(1)], 'ReturnConditions', true, 'Real', true);
S.q1 = simplify(S.q1);

