function [angles] = num_ik(X, arm, robot)
%NUM_IK Summary of this function goes here
%   Detailed explanation goes here

angles = zeros(3,1);
b = 1;




X = X(1:3);
%geometricaly
AB = sqrt((X(1)-0)^2 + (X(2)-0)^2 + (X(3)-robot.bodyHeight)^2);
alph = real(acos((robot.shoulderLength^2 + robot.elbowHeight^2 - AB^2)...
    / (2*robot.shoulderLength * robot.elbowHeight)));
angles(3) = pi - alph;


% if (X(3) - robot.bodyHeight) < 0
%     angles(3) = - angles(3);
% end
rad2deg(angles(3))


angles(2) = real(acos((X(3) - robot.bodyHeight)/(b*robot.elbowHeight*sin(angles(3)))));


rad2deg(angles(2))
%first ang
bottom_p = (X(1) + b*robot.elbowHeight * sin(angles(3))*sin(angles(2)));

upper_p1 = robot.shoulderLength*b +  robot.elbowHeight*b*cos(angles(3));

upper_p2 = sqrt(robot.shoulderLength^2 - X(1)^2 + robot.elbowHeight^2*cos(angles(3))^2 +...
    robot.elbowHeight^2*sin(angles(2))^2*sin(angles(3))^2 +...
    2*robot.elbowHeight*robot.shoulderLength*cos(angles(3)));

% diff configurations
k = -1;

angles(1) = 2*pi - 2*atan2((upper_p1 + k*upper_p2),bottom_p) + b*robot.armAngle;
rad2deg(angles(1))
% if angles(1) > 0
%     angles(1) = 2*pi - angles(1);
% else
%     angles(1) =  -(2*pi -abs(angles(1)));
% end


end