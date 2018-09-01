clear;
constants;

ang = deg2rad([-10 -100 -100]');

[~, pos, ~] = FK3links(ang,"R",robot);

fullMatOld = pos;

newAngles = IK3links(fullMatOld,"R",robot);

rad2deg(newAngles)

fullMatOld
for curAngles=newAngles
%     rad2deg(curAngles)
    [~, pos, ~] = FK3links(curAngles,"R",robot);
fullMatNew = roundn(pos - fullMatOld,-3)
% fullMatNew(3:6) = rad2deg(fullMatNew(3:6));
% fullMatNew
end
