function x = reconstep(ca, cd, rh, rg)
% Performs a one level reconstruction of a signal, given the approximation and detail coefficients.
%
% This function takes the aproxximation and details coefficients at a given
% level, and reconstruct the signal at the previous level in  dwt
% decomposition.
%
% x=reconstep(ca,cd,hr,gr)
% Input:
% ca is a vector with the approximation coefficients.
% cd is a vector with the detail coefficients.
% rh is the low pass reconstruction filter to use.
% rg is the high pass reconstruction filter to use.
% Output:
% x  is the reconstructed signal.
%
% See also: decompstep, wavefilters, dwtreconst.

nh = length(rh);


% The reconstruction filters are used as they are entered.
h = rh;
g = rg;
delay = nh/2;

% Simultaneous upsampling and filtering by circular convolution, with
% filter delay compensation.
x1 = convup(ca,h,delay);
x2 = convup(cd,g,delay);
% The output signal is the sum of both outputs.
x = x1+x2;
