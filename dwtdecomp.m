function [c, l] = dwtdecomp(x, rh, rg, s)
% Dyadic orthogonal discrete wavelet transform decomposition - 
% The signal length must be power of 2.
%
% Performs the dyadic wavelet decomposition up to level s. The maximum
% decomposition level is the number of times the length of the signal can
% be divided by 2 (see function maxlev). If the specified level is not
% possible, the maximum allowed is used. The algorith used is the pyramidal
% method. The signal length must be a power of 2. The algorithm uses
% circular convolutions and thus it uses periodization for the signal
% extension. The
%
% [c,l]=dwtdecomp(x,rh,rg,s)
% Input:
% x   is the signal to decompose.
% rh  is the lowpass reconstruction filter to use.
% rg  is the highpass reconstruction filter to use.
% s   is the desired level of decomposition
% Output:
% c   is a vector that contais concatenated, the decomposition coefficients.
%     For example, if a decomposition to level 3 was specified, it will be
%     c=[a3 d3 d2 d1], where a3 and d3, d2 and d1 are the vectors with the
%     approximation coefficients at level 3 and the detail coefficients for
%     level 3 and the succesive levels.
% l   is a vector with the length of the sub-vectors contained in c, that is, 
%     the length of the approximation coefficient vector at the last level, and
%     the lengths of the vector of detal at each level. Thus its length is s+1. 
% 
%  See also: dwtreconst, wavefilters, maxlevel


p = maxlevel(x);
if p == 0
    disp(['Error: The signal length should be a power of 2.' ...
    'The transform cannot be calculated']);
    c = [];
    l = [];
    return
else
 if s > p
    disp(['Warning: The specified level of decomposition is not allowed.The maximum level ' num2str(p) ' will be used instead']);
    n = p;
 else
    n = s;
 end
end
c = [];
l = length(x);
    
for k = 1:n
   [x, d] = decompstep(x, rh, rg);
   c = [d c];
   l = [length(d) l];
end

c = [x c];
l = [length(x) l];
