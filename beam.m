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
    
    % =============================== Parse inputs
    global lambda w0
    names = {'lambda','w0','conj','modul','norm'}; % Optional argument names
    defaults = {500e-9,1,0,'lagu',1}; % Optional arguments default values
    [lambda,w0,conjugate,modul,C] = parsepvpairs(names,defaults,varargin{:});
    
    % =============================== Useful constants
    r2 = x.^2 + y.^2; % r^2_\perp
    q0 = pi*w0^2/lambda;
    z = z*q0; % UNIDADES DE Z EN DISTANCIAS DE RAYLEIGH
    % Normalize if user asks
    if C == 1
        C = sqrt(2*factorial(radial)/(pi*factorial(radial+abs(angular))));
    end
    
    % =============================== Define terms
    if modul == 'lagu'
        % Call the function for the polynomial term
        modulator = (sqrt(2.*r2)./waist(z)).^abs(angular) .* ...
            laguerg(abs(angular), radial, 2*r2./waist(z).^2).* ...
            exp(1j.*angular.*atan2(y,x)).*...
            exp(1i.*guoys_p(z).*(2*radial+abs(angular)+1));
    elseif modul == 'herm'
        if radial == angular
        % Call the function for the polynomial term
        argx = sqrt(2) .* x ./ waist(z); % Rescaling
        argy = sqrt(2) .* y ./ waist(z); % Rescaling
        modulator = hermite(radial, argx) .* hermite(radial, argy);
        else
            error("Por favor que el argumanto radial sea igual a angular")
        end
    end
    
    wave_front = exp(-1j*(2*pi/lambda).*r2./(2.*(z.^2+q0^2)));
    guoys_phase = 1;
    gauss = w0 .* exp(-(x.^2 + y.^2) ./ waist(z.^2)) ./ waist(z); 
    
    % =============================== Join all terms for the output
    if conjugate
        beem = conj(C .* modulator .* gauss .* wave_front .* guoys_phase);
    else
        beem = C .* modulator .* gauss .* wave_front .* guoys_phase;
    end
end

% ========================= USEFUL AUXILIARY FUNCTIONS =================

function w = waist(z)
    % Returns the waist of the beam at distance z of propagation.
    global lambda w0
    w = (1 / pi) * sqrt(lambda.^2 * z.^2 + pi^2 .* w0^2);
end

% =================  Guoy's phase   =====================

function guoys_phase = guoys_p(z)
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    guoys_phase = atan2(z,q0);
end


