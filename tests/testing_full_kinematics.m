clear;
constants;
arm = "R";
ang = deg2rad([0 0 20 0 5 0]');

[~, pos, orient] = FKfull(ang,arm,robot);

fullMatOld = [pos;orient];
fullMatOld

newAngles = IKfull(fullMatOld,arm,robot);


rad2deg(newAngles)
newAngles = rad2deg(checkFullLim(newAngles,arm,robot))
if isnan(newAngles)
    disp("All solutions exeed joint limits")
else
    for curAngles=newAngles
        [~, pos, orient] = FKfull(curAngles,arm,robot);
        fullMatNew = roundn([pos;orient] - fullMatOld,-5)
        draw_arm(curAngles,arm,robot)
    end
end
