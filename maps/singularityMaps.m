%%
constants;
arm = "L";
AngFullLeft = zeros(6,1);
AngFullHeight = deg2rad([0;0;90;0;0;0]);
[~, CubeHLengh, ~] = FKfull(AngFullLeft,arm,robot);
[~, CubeHHeight, ~] = FKfull(AngFullHeight,arm,robot);

step =0.01;

%%
%Idea  - robot can rotate, thats the reason that cube has the sam i and j
SingularityMatrix = [];
orient = deg2rad[20;-10;15];
% for i= -CubeHLengh(1):step:CubeHLengh(1)
%     for j = -CubeHLengh(1):step:CubeHLengh(1)
%         for k = -CubeHHeight(3):step:CubeHHeight(3)
for i= -CubeHLengh(1):step:CubeHLengh(1)
    for j = -CubeHLengh(2):step:CubeHLengh(2)
        for k = -CubeHLengh(3):step:CubeHLengh(3)
            curAngles = IKfull([i;j;k;orient],arm,robot);
            if isnan(curAngles)
                continue
            else
                curAnglesLims = checkFullLim(curAngles,arm,robot);
                if isnan(curAnglesLims)
                    continue
                else
                    J =[];
                    for curAng = curAnglesLims
                        J = [J;1/cond(JFull(curAng,arm,robot))];
                        % Choose best solution
                        neededJ = max(J);
                        SingularityMatrix = [SingularityMatrix; i j k neededJ];
                    end
                end
            end
        end
    end
end




%% Plot
XR = SingularityMatrix(:,1);
YR = SingularityMatrix(:,2);
ZR = SingularityMatrix(:,3);
CR = SingularityMatrix(:,4);

scatter3(XR,YR,ZR,40,CR,'filled')% draw the scatter plot
xlabel('X, mm')
ylabel('Y, mm')
zlabel('Z, mm')
title('Workspace and singularities for right arm')

cb = colorbar;                                     % create and label the colorbar
cb.Label.String = 'Singularity';