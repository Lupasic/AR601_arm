clear;
constants;

ang = deg2rad([-10 40 -50 50 5 200]');

[~, pos, orient] = FKfull(ang,"R",robot);

fullMatOld = [pos;orient];
fullMatOld

newAngles = IKfull(fullMatOld,"R",robot);

rad2deg(newAngles)


for curAngles=newAngles
    [~, pos, orient] = FKfull(curAngles,"R",robot);
    fullMatNew = roundn([pos;orient] - fullMatOld,-5)
end
