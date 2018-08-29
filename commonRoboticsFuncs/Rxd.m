function [ rotMx ] = Rxd( angle )
%Rotational matrix derivative around X axis
% Arguments
% @angle - (1x1) in rad
% Results
% rotMx - (4x4)
% Examples
% rotMatrix = rotH(1)
%% Validate input arguments
if sum(isnan(angle)) == 0
    validateattributes(angle,{'double','sym'},{'size',[1,1]});
else
    error('Expected input to be non-NaN');
end
%%
%%
temp = [0 0 0 ; 0 -sin(angle) -cos(angle); 0 cos(angle) -sin(angle)];

rotMx = [temp [0;0;0]];
rotMx = [rotMx; [0 0 0 0]];

end

