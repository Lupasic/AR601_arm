function [ lMx ] = Lxd()
%Translation matrix derivative around X axis
% Arguments
% Results
% lMx - (4x4)
% Examples
% lMx = Lxd()
%%
lMx = zeros(4,4);
lMx(1,4) = 1;
end

