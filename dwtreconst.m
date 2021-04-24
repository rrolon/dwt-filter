function x = dwtreconst(c, l, rh, rg)
% Dyadic  orthogonal discrete wavelet transform reconstruction from a previous decomposition.
%
% This function takes a wavelet ecomposition calculated with dwtdecomp, and
% performs the signal reconstruction, using the desired wavelet filters.
%
% x=dwtreconst(c,l,rh,rg)
% Input:
% c   is the vector with decomposition coefficient obtained after
%     dwtdecomp.
% l   is the vector of lengths of the sub vectors in c, as returned by
%     dwtdecomp.
% rh  is the reconstruction low pass filter to use.
% rg  is the reconstruction high pass filter to use.
% Output:
% x   is the synthesized signal.
%
% See also: dwtdecomp, wavefilters, maxlevel.

%calculo los niveles
level = length(l)-2;


% calculo los indices de los coef de detalle
first = cumsum(l)+1;
first = first(1:end-2);
longs = l(2:end-1);
last = first+longs-1;

% itero sobre los de aproximacion
a = c(1:l(1));
for p = 1:level
    d = c(first(p):last(p));
    a = reconstep(a, d, rh, rg);
end
x = a;