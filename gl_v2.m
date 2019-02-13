function gl_v2(x,y,z,lambda,phi0,m,n,conj)
% 
% 
% 

% =================  Gaussian profile   =====================



% =================  Guoy's phase   =====================



% =================  Curved wavefront   =====================


function w = waist(z)
% Returns the waist of the beam at distance z of propagation.
w = (1/pi)*sqrt(lambda.^2*z.^2+pi^2w0^2);

% =================  Laguerre   =====================



function y = laguerg(a,n,x)
% 
% 
% 


% 
if mod(n,2) == 0
    impares = repmat([1 -1],n/2,1);
else
    impares = repmat([1,-1],2*(n-1)/2,1);
end




y = sum(suma);