function beam = gl_v2(x, y, z, lambda, w0, phi0, m, n, conj)
    %
    %
    %
    beam = laguerg().*gaussian
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

% =================  2. Gaussian profile   =====================
function prof = gaussian()
    prof = w0.*exp(-(x.^2+y.^2)./waist(z.^2))./waist(z);
end

function w = waist(z)
    % Returns the waist of the beam at distance z of propagation.
    w = (1 / pi) * sqrt(lambda.^2 * z.^2 + pi^2 .* w0^2);
end

% =================  3. Curved wavefront   =====================

function rayleigh_range = q0(lambda, w0)
    %
    rayleigh_range = pi * w0.^2 / lambda
end
    function curv_rad = R(z)
        % returns the radius of curvature of the wavefront
        curv_rad = z .* (1 + (q_0 ./ z).^2)
    end

    function cwf = curved_wavefront(z)
        % Returns the curved wafvefront resulting from spherical
        % wave distortion
        Cur = k / (2 * R(z))
        cwf = e.^(j .* term1 .* r_perp.^2)
    end
    
% ===================  4. Guoy's phase   =====================
