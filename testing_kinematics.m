clear;
constants;

ang = deg2rad([5 0 60]');

% for bl = [1 2 3; 4 5 6; 7 8 3]'
%     disp(bl)
% end

[X, pos, eulAngle] = FK3links(ang,"L",robot);

fullMatOld = [pos;eulAngle];

newAng = num_ik(fullMatOld,"L",robot);

newAng = mod(newAng,2*pi)

rad2deg(newAng)

[X, pos, eulAngle] = FK3links(newAng,"L",robot);

fullMatOld
fullMatNew = [pos;eulAngle]
