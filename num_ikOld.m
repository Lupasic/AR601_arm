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

allAngles = zeros(3,8);


X = X(1:3);
%geometricaly
AB = norm(X - [0 0 robot.bodyHeight]);
alph = real(acos((robot.shoulderLength^2 + robot.elbowHeight^2 - AB^2)...
    / (2*robot.shoulderLength * robot.elbowHeight)));
angles(3) = pi - alph;

allAngles(3,1:4) = angles(3);
allAngles(3,5:8) = -angles(3);

% if (X(3) - robot.bodyHeight) < 0
%     angles(3) = - angles(3);
% end



for i=[0 4]
    angles(3) = allAngles(3,i+1);
    % singularity value
    if angles(3) == 0
        angles(2) = 0;
    else
        angles(2) = -real(acos((X(3) - robot.bodyHeight)/(b*robot.elbowHeight*sin(angles(3)))));
    end
    %
    allAngles(2,(i+1):(i+2)) = angles(2);
    allAngles(2,(i+3):(i+4)) = -angles(2);
end


%first ang

for i=1:length(allAngles)
    angles(3) = allAngles(3,i);
    angles(2) = allAngles(2,i);
    bottom_p = (X(1) + b*robot.elbowHeight * sin(angles(3))*sin(angles(2)));

    upper_p1 = robot.shoulderLength*b +  robot.elbowHeight*b*cos(angles(3));

    upper_p2 = sqrt(robot.shoulderLength^2 - X(1)^2 + robot.elbowHeight^2*cos(angles(3))^2 +...
        robot.elbowHeight^2*sin(angles(2))^2*sin(angles(3))^2 +...
        2*robot.elbowHeight*robot.shoulderLength*cos(angles(3)));

    % diff configurations
    k = -1;
%     if mod(i,2)
%         k = -1;
%     else
%         k = -1;
%     end
    angles(1) = 2*pi-2*atan2((upper_p1 + k*upper_p2),bottom_p) + b*robot.armAngle;
    allAngles(1,i) = angles(1);

    % rad2deg(angles(1))
end
% for i=1:size(allAngles,1)
%     for j=1:size(allAngles,2)
%         if allAngles(i,j) >= 0
%             allAngles(i,j) = mod(allAngles(i,j),2*pi);
%         else
%             allAngles(i,j) = mod(allAngles(i,j),-2*pi);
%         end
%     end
% end

% if angles(1) > 0
%     angles(1) = 2*pi - angles(1);
% else
%     angles(1) =  -(2*pi -abs(angles(1)));
% end

end