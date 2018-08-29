function [ rotMz ] = Rzd( angle )
%Rotational matrix derivative around Z axis
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
temp = [-sin(angle) -cos(angle) 0;cos(angle) -sin(angle) 0 ; 0 0 0];

rotMz = [temp [0;0;0]];
rotMz = [rotMz; [0 0 0 0]];

end

