function [allAngles] = IKfull(X, arm, robot)

if arm == "R"
    b = -1;
elseif arm == "L"
    b = 1;
else
    b = 1;
    disp('Incorrect letter, calculate as "L" arm');
end


T = transH([X(1);X(2);X(3)]) * [eul2rotm(X(4:6)','ZYX') [0;0;0];[0 0 0 1]];
T0 = T * inv(transH([0;b*robot.wristLength;0]));

pos=T0(1:3,4);


%% Third angle (geometricaly)
q31=-acos(roundn(-(robot.shoulderLength^2 + robot.elbowHeight^2-norm(pos-[0 0 robot.bodyHeight]')^2)...
    /(2*robot.shoulderLength * robot.elbowHeight),-10));

%% Second angle (from FK)
q21=acos(roundn(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(-q31)),-10));
q24=acos(roundn(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(q31)),-10));

%% First angle (geometricaly)
phi=acos((robot.bodyHeight-pos(3))/robot.elbowHeight);
[xout,yout] = circcirc(0,0,robot.shoulderLength,pos(1),pos(2),robot.elbowHeight*sin(phi));

if b==1
    q11=atan2(yout(2),xout(2))-pi/2 + robot.armAngle;
    q12=atan2(yout(1),xout(1))-pi/2 + robot.armAngle;
else
    q11=atan2(yout(2),xout(2))+pi/2 - robot.armAngle;
    q12=atan2(yout(1),xout(1))+pi/2 - robot.armAngle;
end
allAngles=[q11 q12 q11 q12; q21 -q21 -q24 q24; q31 q31 -q31 -q31;zeros(3,4)];


%% Last 3 angles

i=0;
eps = 0.001;
for angles = allAngles
    i = i +1;
    T123 = rotH([0;0;angles(1)]) * transH([0;0;robot.bodyHeight]) *...
        rotH([0;0;-b*robot.armAngle])* transH([0;b*robot.shoulderLength;0]) *...
        rotH([0;angles(2);0]) * rotH([angles(3);0;0]) * transH([0;b*robot.elbowHeight;0]);
    T456 = inv(T123) * T0;

    
    if abs(abs(T456(2,2)) - 1) < eps
        allAngles(5,i) = acos(roundn(T456(2,2),-10));
        disp("singularity");
        
    else
        allAngles(4,i) = atan2(T456(3,2),-T456(1,2));
        allAngles(6,i) = atan2(T456(2,3),T456(2,1));
        if abs(T456(2,1)) < eps
            allAngles(5,i) = atan2(T456(2,3)/sin(allAngles(6,i)),T456(2,2));
        else
            allAngles(5,i) = atan2(T456(2,1)/cos(allAngles(6,i)),T456(2,2));
        end
    end
    
end

end