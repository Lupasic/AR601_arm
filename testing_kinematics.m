clear;
constants;

ang = deg2rad([-105 150 135]');

[~, pos, ~] = FK3links(ang,"L",robot);

fullMatOld = pos;

newAngles = num_ik(fullMatOld,"L",robot);

rad2deg(newAngles)

fullMatOld
for curAngles=newAngles
%     rad2deg(curAngles)
    [~, pos, ~] = FK3links(curAngles,"L",robot);
fullMatNew = roundn(pos - fullMatOld,-3)
% fullMatNew(3:6) = rad2deg(fullMatNew(3:6));
% fullMatNew
end
