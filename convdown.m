function y = convdown(x, h, delay)
% Circular convolution and downsampling by a factor of 2.
%
% This function performs the filtering of a signal and posterior
% subsampling by a factor of two. Given that half the samples would be
% eliminated by the subsampling, it is not necessary to calculate their
% values, which reduces the amount of operations needed by 2. The function
% also includes an arbitrary delay, which is applyed as a circular shift
% given the circular convolutions used. This is usefull to compensate for
% the delay introduced in the filtering operation.
%
% y=convolc(x,h,delay)
% Input:
% x      is the signal co filter and downsample.
% h      is the filter to use.
% delay  is the circular shift (positive or negative) to use.
% Output:
% y      is the filtered and dowunsampled signal.
%
% See also: convup, decompstep, dwtdecomp.

n = length(x);
m = length(h); 

p = delay;
if mod(p,2) == 1
    p = p+1;
end

n2 = n/2;
y = zeros(1, n2);
for k = 1:n2
   for l = 1:m
       y(k) = y(k)+x(mod(n+p+(2*k-1)-l,n)+1)*h(l);
   end
end