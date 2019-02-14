function gl = gl_v2(x, y, z, lambda, w0, phi0, m, n, conj)
    %
    %
    %
    q0 = q_0(lambda, w0)
    R = rad_curvature(z, q0)

    modulator = laguerre_modulator() % in development
    curved_wf = curved_wavefront(x, y, R, lambda)
    guoys_phase = guoys_p(z, q0)

    gl = modulator .* curved_wf .* guoys_phase 
end

% PARAXIAL WAVE FACTORS:

% =================  1. Laguerre-Gauss modulator   =====================

function f = laguerre_modulator() % missing parameters
    glp = laguerg(a, n, x)

end

function glp = laguerg(a, n, x)
    %
    % Returns the Generalized Laguerre Polynomials given constants 
    % a and n: L_n^a(x) = sum_{i=0}^n((-1)^i nCr(n+a, n-i) x^i/i!)
    %
    if mod(n, 2) == 0
        impares = repmat([1 - 1], n / 2, 1);
    else
        impares = repmat([1; -1], (n - 1) / 2, 1);
        impares = [impares; 1]
    end

    index = [1:n]'
    n = ones(n, 1)

    combinations = nCk(n + a, n - index)

    glp = sum(impares .* combinations .* x .^ i ./ factorial(i));
end

function nk = nCk(n, k)
    % Vectorized version of NCHOOSEK().
    nk = factorial(n) ./ (factorial(k) .* factorial(n - k));
end

% =================  2. Gaussian profile   =====================

function prof = gaussian()
    prof = w0 .* exp(-(x.^2 + y.^2) ./ waist(z.^2)) ./ waist(z);
end

function w = waist(z, w0, lambda)
    % Returns the waist of the beam at distance z of propagation.
    w = (1 / pi) * sqrt(lambda.^2 * z.^2 + pi^2 .* w0^2);
end

% =================  3. Curved wavefront   =====================

function q0 = rayleigh_range(lambda, w0)
    % Returns the Rayleigh range given wavelength and frequency
    q0 = pi .* w0.^2 ./ lambda
end

function R = rad_curvature(z, q0)
    % returns the radius of curvature of the wavefront
    R = z .* (1 + (q0 ./ z).^2)
end

function curved_wf = curved_wavefront(x, y, R, lambda)
    % Returns the curved wafvefront resulting from spherical
    % wave distortion
    curvature = 2 .* pi ./ (2 .* R .* lambda)
    curved_wf = exp(j .* curvature .* (x.^2 + y.^2))
end

% =================  4. Guoy's phase   =====================

function guoys_phase = guoys_p(z, q0)
    guoys_phase = exp(-j .* atan(z ./ q0))
end
