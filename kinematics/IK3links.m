function [allAngles] = IK3links(X, arm, robot)

%% Validate input arguments
if isnan(X)
    disp ("Expected input to be non-NaN");
    return
end
validateattributes(X,{'double','sym'},{'size',[6,1]});
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


%% Third angle (geometricaly)
pos = X(1:3);

q31=-acos(roundn(-(robot.shoulderLength^2 + robot.elbowHeight^2-norm(pos-[0 0 robot.bodyHeight]')^2)...
    /(2*robot.shoulderLength * robot.elbowHeight),-5));

if imag(q31) ~= 0
    allAngles = NaN;
    return
end

%% Second angle (from FK)
if q31 == 0
    q21 = 0;
    q24 = 0;
else
    q21=acos(roundn(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(-q31)),-5));
    q24=acos(roundn(-(pos(3)-robot.bodyHeight)/(b*robot.elbowHeight*sin(q31)),-5));
end
if imag(q21) ~= 0 || imag(q24) ~= 0
    allAngles = NaN;
    return
end

%% First angle (geometricaly)
phi=acos(roundn((robot.bodyHeight-pos(3))/robot.elbowHeight,-5));
if imag(phi) ~= 0
    allAngles = NaN;
    return
end
[xout,yout] = circcirc(0,0,robot.shoulderLength,pos(1),pos(2),robot.elbowHeight*sin(phi));
if isnan(xout) || isnan(yout)
    allAngles = NaN;
    return
end
if b==1
    q11=atan2(yout(2),xout(2))-pi/2 + robot.armAngle;
    q12=atan2(yout(1),xout(1))-pi/2 + robot.armAngle;
else
    q11=atan2(yout(2),xout(2))+pi/2 - robot.armAngle;
    q12=atan2(yout(1),xout(1))+pi/2 - robot.armAngle;
end

if imag(q11) ~= 0 || imag(q12) ~= 0
    allAngles = NaN;
    return
end

allAngles=[q11 q12 q11 q12; q21 -q21 -q24 q24; q31 q31 -q31 -q31];
end