function E = BGBeam(m,X,Y,z,)
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
th=atan2(Y, X);
if isempty(varargin) % Caso donde no hay entradas opcionales
    lambda = 500e-9; % Defalut lambda
    z = 0; % Defalut z
elseif length(varargin) == 1 % Solo z fue especificado
    z = varargin{1};
    lambda = 500e-9;
else
    z = varargin{1}; % z es el primer arg
    lambda = varargin{2}; % Lambda es el segundo arg
end
k = 2*pi/lambda; % Wave number
q0 = pi*w^2/lambda;
z = z*q0; % Rayleigh length units
rr2=(X.^2+Y.^2)/waist(z)^2;


% ================ EVALUACION ==========================
% For z = 0
E = 

% Include terms for z > 0
E = E .* exp(1j*(2*p + abs(l) + 1).*guoys_p(z)); % Guoys phase term
E = E .* exp(-1j.*k.*rr2.*waist(z)^2.*z./(2.*z.^2 + 2*q0^2)) ./ (waist(z)); % Wavefront term
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