function [limitedAng] = checkFullLim(angles, arm, robot)
%% Validate input arguments
if isnan(angles)
    disp ("Expected input to be non-NaN");
    return
end
validateattributes(angles,{'double','sym'},{'size',[6,NaN]});
validateattributes(arm,{'string','char'},{'size',[1,1]});
validateattributes(robot,{'struct'},{});
%%

%%
limitedAng =[];
for curSet = angles
    if arm == "R"
        if sum(robot.limitsR(1:end,1) <= curSet) == length(curSet) ...
                && sum(robot.limitsR(1:end,2) >= curSet) == length(curSet)
            limitedAng = [limitedAng curSet];
        end
    else
        if sum(robot.limitsL(1:end,1) <= curSet) == length(curSet) ...
                && sum(robot.limitsL(1:end,2) >= curSet) == length(curSet)
            limitedAng = [limitedAng curSet];
        end
    end
end
if isempty(limitedAng)
    limitedAng = NaN;
end
end

