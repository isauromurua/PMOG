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
    
    % ============== Parse inputs ==============
    global lambda w0
    names = {'lambda','w0','conj','modul','norm'}; % Optional argument names
    defaults = {850e-9,5e-2,0,'lagu',1}; % Optional arguments default values
    [lambda,w0,conjugate,modul,C] = parsepvpairs(names,defaults,varargin{:});
    
    q0 = pi .* w0.^2 ./ lambda; % Rayleigh range
    z = z.*q0; % Unidades de distancias de Rayleigh
    
    % Normalization constant
    if C
        C = sqrt(2*factorial(radial)/(pi*factorial(radial+abs(angular))));
    else
        C = 1;
    end
    
    if modul == 'lagu'
        % Laguerre
        r2 = x.^2 + y.^2;
        modulator = (sqrt(2.*r2)./waist(z)).^abs(angular) .* ...
            laguerg(abs(angular), radial, 2*r2./waist(z).^2).* ...
            exp(1j.*angular.*atan2(y,x)).*...
            exp(1j.*gouys_p(z).*(2*radial+abs(angular)));
    elseif modul == 'herm'
        % Hermite
        r2 = x.^2 + y.^2;
        argx = sqrt(2) .* x ./ waist(z); % Rescaling
        argy = sqrt(2) .* y ./ waist(z); % Rescaling
        modulator = hermite(radial, argx) .* hermite(radial, argy);
    end
    
    % ============== Define each term ==============
    curved_wf = exp(-1j *(2*pi/lambda) .* r2 .* z / (2*(z.^2+q0)));
    gauss = w0*exp(-r2 ./ waist(z.^2)) ./ waist(z);
    gouys_phase = exp(1j*gouys_p(z));
    
    % ============== Join all terms together for the output ==============
    if conjugate
        beem = conj(C .* modulator .* gauss .* curved_wf .* gouys_phase);
    else
        beem = C .* modulator .* gauss .* curved_wf .* gouys_phase;
    end
end

% PARAXIAL WAVE FACTORS:


% =================  1. Gaussian profile   =====================

function prof = gaussian(x,y,z)
    global w0
    prof = w0 .* exp(-(x.^2 + y.^2) ./ waist(z.^2)) ./ waist(z);
end

function w = waist(z)
    % Returns the waist of the beam at distance z of propagation.
    global lambda w0
    q0 = pi * w0^2 / lambda;
    w = w0^2 * sqrt(1 + (z / q0));
end

% =================  2. Wavefront   ===========================

function curved_wf = wavefront(x, y, z)
    % Returns the curved wafvefront resulting from spherical
    % wave distortion
    global lambda w0
%     R = rad_curvature(z);
    r2 = x.^2 + y.^2;
%     curvature = 2 .* pi ./ (2 .* R .* lambda);
%     curved_wf = exp(1j .* curvature .* (x.^2 + y.^2));
    curved_wf = exp(-1j *(2*pi/lambda) .* r2 .* z / (2*z.^2+(pi*w0^2/lambda)));
end

function R = rad_curvature(z)
    % Returns the radius of curvature of the wavefront
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    R = z .* (1 + (q0 ./ z).^2);
end
% =================  3. Guoy's phase   =======================

function gouys_phase = gouys_p(z)
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda; % Rayleigh range
    gouys_phase = atan2(z,q0);
end