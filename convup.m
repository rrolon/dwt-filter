function y = convup(x, h, delay)
% Circular convolution and upsampling by a factor of 2.
%
% This function implements a upsampling and filtering using a circular
% convolution. Instead of first upsampling inserting zeroes and then
% convolving, half the calculations can be avoided by not using those
% zeroes and only using the values that are knwn to be nonzero. This is
% used by dwtreconst to perform dyadic wavelet reconstruction. The function
% also allows to introduce an arbitrary delay wich is translated as a
% circular shift of the output signal. this is usefull for compensation of
% the filter delay.
%
% y=convolc(x,h,delay)
% Input:
% x      is the signal to upsample and filter.
% h      is the filter to use.
% delay  is the number of samples (positive or negative) to apply as a
%        circular shift to the signal
% Output:
% y      is the output upsampled and filtered signal.
%
% See also: condown, reconstep, dwtreconst.

n = length(x);
m = length(h);

p = delay;
if mod(delay,2)==1
    p = p+1;
end

t = 2*n;
y = zeros(1,t);

for k = 1:n
   for l = 1:m/2
      y(mod(2*k-delay-1,t)+1) = y(mod(2*k-delay-1,t)+1)+x(mod(n+(k-l),n)+1)*h(2*l-1);
      y(mod(2*k-delay,t)+1) = y(mod(2*k-delay,t)+1)+x(mod(n+(k-l),n)+1)*h(2*l);
   end
end


