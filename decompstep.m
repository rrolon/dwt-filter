function [ca,cd]=decompstep(x,rh,rg)
% Performs a one-level dyadic wavelet decomposition of signal x.
%
% This function performs a one level step in the dyadic orthogonal wavelet
% decompositon by the pyramidal algorithm. The signal is filtered with the
% low pass and high pass decomposition filters and after that, both signals
% are subsampled by a factor of 2. The decomposition filters are
% constructed by time-reversion of the reconstruction filters.
%
% [ca,cd]=decompstep(x,hr,gr,gra)
% Intput: 
% x:  is the signal to decompose.
% rh: is the reconstruction low pass filter to use.
% rg: is the reconstruction high pass filter to use.
% Output: 
% ca  is the vector of aproximation coefficients.
% cd  is the vector of detail coefficients.
%
% See also: reconstep, wavefilters, dwtdecomp.

% construction of the decomposition filters (time reversion of the
% reconstruction filters)
h=fliplr(rh);
g=fliplr(rg);

nh=length(h);

delay=nh/2;

%simultaneous filtering and subsampling using circular convolutions, with
%delay compensation
ca=convdown(x,h,delay); 
cd=convdown(x,g,delay);
