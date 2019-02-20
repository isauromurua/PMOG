function be = beam(x, y, z, n, m, varargin)
    %
    %
    %
    
    % Parse inputs
    global lambda w0 j
    names = {"lambda","w0","conj"}; % Optional argument names
    defaults = {500e-9,1,0}; % Optional arguments default values
    [lambda,w0,conj] = parsepvpairs(names,defaults,varargin{:});
    
    % Make conjugate if necessary
    if conj
        j = -1j;
    else
        j = 1j;
    end
    
    % Call the function defined for each term
    modulator = laguerre_modulator(n,m,x,y,z);
    curved_wf = curved_wavefront(x, y, z);
    guoys_phase = guoys_p(z);
    gauss = gaussian(x,y,z);
    
    % Join all terms together for the output
    be = modulator .* gauss .* curved_wf .* guoys_phase;
end

% PARAXIAL WAVE FACTORS:

% =================  1. Laguerre modulator   =====================

function f = laguerre_modulator(a,n,x,y,z)
    % Returns the Laguerre function as modulating wave
    global j
    r2 = x.^2 + y.^2;
    f = (sqrt(2.*r2)./waist(z)).^n .* ...
        laguerg(a, n, 2*r2./waist(z)).*exp(j.*a.*atan2(y,x)).*...
        exp(j*(2*n+a).*guoys_p(z));
end

function glp = laguerg(a, n, x)
    % Returns the generalized Laguerre Polynomials valued at x,
    %   given constants a and n: 
    %   L_n^a(x) = sum_{i=0}^n((-1)^i nCr(n+a, n-i) x^i/i!)
    taman = size(x,2);
    if ndims(x) == 2
        X = repmat(x,1,1,n+1);
        index = permute(repmat((0:n)',1,taman,taman),[3 2 1]); % Summation index
        combinations = nCk(n + a, n - index); % Binomial coefficient for each term
        glp = sum((-1) .^ index .* combinations .* X .^ index ./ factorial(index),3);
%         surf(glp);
    elseif ndims(x) == 3
        X = repmat(x,1,1,1,n+1);
        % Aqui van mas cosas
    end
end

function nk = nCk(n, k)
    % Vectorized version of nchoosek()
    nk = factorial(n) ./ (factorial(k) .* factorial(n - k));
end

% =================  2. Gaussian profile   =====================

function prof = gaussian(x,y,z)
    global w0
    prof = w0 .* exp(-(x.^2 + y.^2) ./ waist(z.^2)) ./ waist(z);
end

function w = waist(z)
    % Returns the waist of the beam at distance z of propagation.
    global lambda w0
    w = (1 / pi) * sqrt(lambda.^2 * z.^2 + pi^2 .* w0^2);
end

% =================  3. Curved wavefront   =====================

function curved_wf = curved_wavefront(x, y, z)
    % Returns the curved wafvefront resulting from spherical
    % wave distortion
    global lambda j
    R = rad_curvature(z);
    curvature = 2 .* pi ./ (2 .* R .* lambda);
    curved_wf = exp(j .* curvature .* (x.^2 + y.^2));
end

function R = rad_curvature(z)
    % Returns the radius of curvature of the wavefront
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    R = z .* (1 + (q0 ./ z).^2);
end
% =================  4. Guoy's phase   =====================

function guoys_phase = guoys_p(z)
    global lambda w0 j
    q0 = pi .* w0.^2 ./ lambda;
    guoys_phase = exp(-j .* atan(z ./ q0));
end
