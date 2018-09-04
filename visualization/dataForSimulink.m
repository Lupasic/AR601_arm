constants;
%Torso rotation angle is taken from angL
angL = deg2rad([0 0 0 0 0 0]');
angR = deg2rad([0 0 0 0 0 0]');


% newAngles = IKfull(fullMatOld,arm,robot);


% rad2deg(newAngles)
% newAngles = rad2deg(checkFullLim(newAngles,arm,robot))
% % if isnan(newAngles)
%     disp("All solutions exeed joint limits")
% else
%     for curAngles=newAngles
%         [~, pos, orient] = FKfull(curAngles,arm,robot);
%         fullMatNew = roundn([pos;orient] - fullMatOld,-5)
%         draw_arm(curAngles,arm,robot)
%     end
% end