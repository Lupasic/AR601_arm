function [ lMy ] = Lyd()
%Translation matrix derivative around X axis
% Arguments
% Results
% lMx - (4x4)
% Examples
% lMx = Lxd()
%%
lMy = zeros(4,4);
lMy(2,4) = 1;
end

