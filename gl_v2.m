function gl_v2(x, y, z, lambda, w0, phi0, m, n, conj)
    %
    %
    %
    q0 = q_0(lambda, w0)
    R = rad_curvature(z, q0)
    curved_wf = curved_wavefront(x, y, R)

end

% PARAXIAL WAVE FACTORS:

% =================  1. Laguerre modulator   =====================

function y = laguerg(a, n, x)
    %
    %
    %
    if mod(n, 2) == 0
        impares = repmat([1 - 1], n / 2, 1);
    else
        impares = repmat([1, -1], 2 * (n - 1) / 2, 1);
    end
    
    
    y = sum(suma);
end

function nk = nCk(n,k)
% Vectorized version of NCHOOSEK().
    nk = factorial(n)./(factorial(k).*factorial(n-k));
end
% =================  2. Gaussian profile   =====================
function prof = gaussian()
    prof = w0.*exp(-(x.^2+y.^2)./waist(z.^2))./waist(z);
end

function w = waist(z)
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

function curved_wf = curved_wavefront(x, y, R)
    % Returns the curved wafvefront resulting from spherical
    % wave distortion
    curvature = k ./ (2 .* R)
    curved_wf = e.^(j .* curvature .* (x.^2 + y.^2))
end

% =================  4. Guoy's phase   =====================

function gouys_phase = gouys_p(z, lambda)


