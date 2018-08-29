function [ rotMatrix ] = rotH( angle )
%Full rotation, represented as Homoginious matrix
% Arguments
% @angle - (3x1) in rad
% Results
% rotMatrix - (4x4)
% Examples
% rotMatrix = rotH( [0;0;0] )
%% Validate input arguments
if sum(isnan(angle)) == 0
    validateattributes(angle,{'double','sym'},{'size',[3,1]});
else
    error('Expected input to be non-NaN');
end
%%

rotMx = [1 0 0 ; 0 cos(angle(1)) -sin(angle(1)); 0 sin(angle(1)) cos(angle(1))];
rotMy = [cos(angle(2)) 0 sin(angle(2)); 0 1 0 ; -sin(angle(2)) 0 cos(angle(2))];
rotMz = [cos(angle(3)) -sin(angle(3)) 0 ;sin(angle(3)) cos(angle(3)) 0 ; 0 0 1];
temp = rotMz * rotMy * rotMx;

rotMatrix = [temp [0;0;0]];
rotMatrix = [rotMatrix; [0 0 0 1]];

end

