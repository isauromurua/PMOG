function y = bessel(m,x)
% Bessel functions of the first kind.
%   y = BESSEL(m.x) accepts any size input for x,
%    and y is the elemntwise Bessel evaluated at x.


if m>=2
    y = (2*(m-1)./x).*bessel(m-1,x) - bessel(m-2,x);
elseif m == 1
    y = NaN;
elseif m == 0
    y = NaN;
end