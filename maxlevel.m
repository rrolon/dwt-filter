function n = maxlevel(x)
% Determines the maximum level of decomposition for a dyadic wavelet 
% transform.
%
% This function takes a signal and determines the maximum level of dyadic 
% orthogonal wavelet decomposition that can be used on it. This level is
% equal to the number of times the signal can be divided by two. This 
% works only for signals whose length is power of two.
% 
% n = maxlevel(x)
% Input:
% x is the input signal.
% Output:
% n is the maximum admisible level of decomposition.
%
% See also: dwtdecomp, dwtreconst, wavefilters.

n = 0;
p = length(x);
while rem(p,2) == 0
    p = p/2;
    n = n+1;
end