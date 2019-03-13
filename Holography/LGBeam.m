function [E] = LGBeam(p, l, w, xx, yy, varargin)
% Generates a Laguerre-Gaussian Beam on coordinates [xx, yy] with parameters 
%    p: radial order
%    l: topologial charge
%    w: initial radius
% Optional values:
%    varargin{1} = Propagation distance (default = 0 Rayleigh distances)
%    varargin{2} = Wavelength (default = 500 nm)
global w0 lambda
w0 = w;

% Auxiliary values
th=atan2(yy, xx);
if isempty(varargin)
    lambda = 500e-9;
    z = 0;
elseif length(varargin) == 1
    z = varargin{1};
    lambda = 500e-9;
else
    z = varargin{1};
    lambda = varargin{2};
end
k = 2*pi/lambda; % Wave number
q0 = pi*w^2/lambda;
z = z*q0; % Rayleigh length
rr2=(xx.^2+yy.^2)/waist(z)^2;

% For z = 0
E = (2*rr2).^(abs(l)/2).*exp(-rr2+1i*l*th).*laguerg(p, abs(l), 2*rr2);

% Include terms for z > 0
E = E .* exp(1j*(2*p + abs(l) + 1).*guoys_p(z)); % Guoys phase term
E = E .* exp(1j.*k.*rr2.*waist(z)^2.*z./(2.*z.^2 + 2*q0^2)) ./ (waist(z)^2); % Wavefront term
end

% ========================= USEFUL AUXILIARY FUNCTIONS =================

function waist = waist(z)
    % Returns the waist of the beam at distance z of propagation.
    global w0 lambda
    q0 = pi*w0^2/lambda;
    waist = w0 * sqrt(1 + z./q0);
end

% =================  Guoy's phase   =====================

function guoys_phase = guoys_p(z)
    global lambda w0
    q0 = pi .* w0.^2 ./ lambda;
    guoys_phase = atan2(z,q0);
end