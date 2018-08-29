function [ T ] = transH( L )
% Translation matrix, represented as Homoginious matrix
% Arguments
% @L - (3x1) in meters
% Results
% rotMatrix - (4x4)
% Examples
% T = transH( [0;0;0] )

%% Validate input arguments
if sum(isnan(L)) == 0
    validateattributes(L,{'double','sym'},{'size',[3,1]});
else
    error('Expected input to be non-NaN');
end
%%
%%

T = [1 0 0 L(1); 0 1 0 L(2); 0 0 1 L(3); 0 0 0 1];

end

