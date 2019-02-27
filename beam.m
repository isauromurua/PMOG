function beem = beam(x, y, z, m, n, varargin)
    % Paraxial approximation modulated beams.
    %   Accepts the following name-value pairs:
    %       'modul' – 'lag' is Laguerre modulator
    %               – 'herm' is Hermite modulator
    %       'lambda'– Wavelength in nm.
    %       'w0'    – Waist of the beam at z=0
    %       'conj'  – Output phasor conjugate
    
    % Parse inputs
    global lambda w0
    names = {'lambda','w0','conj','modul'}; % Optional argument names
    defaults = {500e-9,1,0,'lagu'}; % Optional arguments default values
    [lambda,w0,conjugate,modul] = parsepvpairs(names,defaults,varargin{:});
    
    if modul == 'lagu'
        % Call the function defined for each term
        modulator = laguerre_modulator(m,n,x,y,z);
        curved_wf = 1;%curved_wavefront(x, y, z);
        guoys_phase = guoys_p(z);
        gauss = gaussian(x,y,z);
    elseif modul == 'herm'
        % Call the function defined for each term
        modulator = hermite_modulator(m,n,x,y,z);
        curved_wf = 1;%curved_wavefront(x, y, z);
        guoys_phase = guoys_p(z);
        gauss = gaussian(x,y,z);
    end
    
    % Join all terms together for the output
    if conjugate
        beem = conj(modulator .* gauss .* curved_wf .* guoys_phase);
    else
        beem = modulator .* gauss .* curved_wf .* guoys_phase;
=======
=======
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
function beem = beam(x, y, z, radial, angular, varargin)
    % Paraxial approximation modulated beams.
    %
    %          beem = BEAM(x,y,z, radial, angular) returns an array
    %          evaluated point-wise at x,y,z with modes angular and radial.
    % 
    %           Accepts the following name-value pairs:
    %               'modul' – 'lag' is Laguerre modulator
    %                       – 'herm' is Hermite modulator
    %               'lambda'– Wavelength in nm.
    %               'w0'    – Waist of the beam at z=0
    %               'conj'  – Flag to return phasor conjugate
    
    % Parse inputs
    global lambda w0
    names = {'lambda','w0','conj','modul','norm'}; % Optional argument names
    defaults = {500e-9,1,0,'lagu',1}; % Optional arguments default values
    [lambda,w0,conjugate,modul,C] = parsepvpairs(names,defaults,varargin{:});
    
    if modul == 'lagu'
        % Call the function for the polynomial term
        modulator = laguerre_modulator(radial,angular,x,y,z);
    elseif modul == 'herm'
        % Call the function for the polynomial term
        modulator = hermite_modulator(radial,angular,x,y,z);
    end
    
    % Call each function
    curved_wf = 1;%curved_wavefront(x, y, z);
    guoys_phase = guoys_p(z);
    gauss = gaussian(x,y,z); 
    
    % Join all terms together for the output
    if conjugate
        beem = conj(C .* modulator .* gauss .* curved_wf .* guoys_phase);
    else
        beem = C .* modulator .* gauss .* curved_wf .* guoys_phase;
<<<<<<< HEAD
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
=======
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
    end
end

% PARAXIAL WAVE FACTORS:

% =================  1.1 Laguerre modulator   =====================

<<<<<<< HEAD
<<<<<<< HEAD
function f = laguerre_modulator(m,n,x,y,z)
    % Returns the Laguerre function as modulating wave
    r2 = x.^2 + y.^2;
%     f = (sqrt(2.*r2)./waist(z)).^m .* ...
%         laguerg(n, m, 2*r2./waist(z).^2).*exp(1j.*n.*atan2(y,x)).*...
%         exp(1j*(2*m+n).*guoys_p(z));
    f = (sqrt(2.*r2)./waist(z)).^m .* ...
        laguerg(n, m, 2*r2./waist(z)).*exp(1j.*n.*atan2(y,x)).*...
        guoys_p(z);
=======
=======
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
function f = laguerre_modulator(radial,angular,x,y,z)
    % Returns the Laguerre function as modulating wave
    r2 = x.^2 + y.^2;
    f = (sqrt(2.*r2)./waist(z)).^abs(angular) .* ...
        laguerg(abs(angular), radial, 2*r2./waist(z).^2).* ...
        exp(1j.*angular.*atan2(y,x)).*...
        exp(1i.*guoys_p(z).*(2*radial+abs(angular)+1));
<<<<<<< HEAD
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
=======
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
end

function nk = nCk(n, k)
    % Vectorized version of nchoosek()
    nk = factorial(n) ./ (factorial(k) .* factorial(n - k));
end

% =================  1.2 Hermite modulator   =====================

function hmn = hermite_modulator(a, n, x, y, z)
    % Returns the Hermite-Gauss function as modulating wave
    
<<<<<<< HEAD
<<<<<<< HEAD
    arg = sqrt(2) .* x ./ waist(z); % por completar
    hmn = hermite(a, arg) .* hermite(n, arg);
=======
    argx = sqrt(2) .* x ./ waist(z); % Rescaling
    argy = sqrt(2) .* y ./ waist(z); % Rescaling
    hmn = hermite(a, argx) .* hermite(n, argy);
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
=======
    argx = sqrt(2) .* x ./ waist(z); % Rescaling
    argy = sqrt(2) .* y ./ waist(z); % Rescaling
    hmn = hermite(a, argx) .* hermite(n, argy);
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
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
    global lambda
    R = rad_curvature(z);
    curvature = 2 .* pi ./ (2 .* R .* lambda);
    curved_wf = exp(1j .* curvature .* (x.^2 + y.^2));
end

function R = rad_curvature(z)
    % Returns the radius of curvature of the wavefront
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    R = z .* (1 + (q0 ./ z).^2);
end
% =================  4. Guoy's phase   =====================

function guoys_phase = guoys_p(z)
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    guoys_phase = exp(-1j .* atan(z ./ q0));
<<<<<<< HEAD
<<<<<<< HEAD
end
=======
end
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
=======
end
>>>>>>> 9217778e8794e660d0c6908617b958e2298526a2
