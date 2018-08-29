function [ lMz ] = Lzd()
%Translation matrix derivative around X axis
% Arguments
% Results
% lMx - (4x4)
% Examples
% lMx = Lxd()
%%
lMz = zeros(4,4);
lMz(3,4) = 1;
end

