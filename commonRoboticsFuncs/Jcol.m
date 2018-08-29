function [J] = Jcol(T)
% Return pos and orientation from Jacobean (solved by numarical approach)
% Arguments
% @T - (4x4) - Homogenious matrix
% Results
% J - (1x6)
% Examples
% J = Jcol([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 0 1])

%% Validate input arguments
if sum(isnan(T)) == 0
    validateattributes(T,{'double','sym'},{'size',[4,4]});
else
    error('Expected input to be non-NaN');
end
%%
%%

J = [T(1,4), T(2,4), T(3,4), T(3,2), T(1,3), T(2,1)]' ;

