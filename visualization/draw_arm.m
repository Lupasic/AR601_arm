function draw_arm(anglesAll, arm, robot )
% Calculate forward kinematics for arm
% @arm - string "L" or "R"
% @angles - angles array (6x1)
% @robot - constants for robot

%% Validate input arguments
if isnan(anglesAll)
    disp ("Expected input to be non-NaN");
    return
end
validateattributes(anglesAll,{'double','sym'},{'size',[6,NaN]});
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

for angles = anglesAll
    points=zeros(5,3);
    points(1,:)=[0 0 0];
    
    T01 = rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
        rotH([0;0;-b*robot.armAngle]);
    points(2,:) = T01(1:3,4);
    
    
    T02 = T01 * transH([0;b*robot.shoulderLength;0]);
    points(3,:) = T02(1:3,4);
    
    T03 =  T02*rotH([0;angles(2);0]) * rotH([angles(3);0;0]) * transH([0;b*robot.elbowHeight;0]);
    points(4,:) = T02(1:3,4);
    
    T456 = rotH([0;angles(4);0])*rotH([0;0;angles(5)])*rotH([0;angles(6);0]);
    T06 = T03 * T456 * transH([0;b*robot.wristLength;0]);
    
    points(5,:)=T06(1:3,4);
    
    for i=1:(size(points,1)-1)
        plot3(points(i:i+1,1),points(i:i+1,2),points(i:i+1,3),'LineWidth',3)
        hold on;
    end
    grid on
    xlabel('x')
    ylabel('y')
    zlabel('z')
end
end

