% function [ E ] = propagate(E0, z, varargin)
% % x,y: Transversal coordinates
% % z: Propagation distance
% % E0: Initial field distribution
% %    Optional values:
% %      varargin{1} = wavelength
% %      varargin{2} = Transverse wavenumber
% 
% 
% if isempty(varargin) % Caso donde no hay entradas opcionales
%     lambda = 500e-9; % Defalut lambda
%     kt = 0; % Defalut kt
%     w = 1e-1;
% elseif length(varargin) == 1 % Solo lambda fue especificado
%     lambda = varargin{1};
%     kt = 0;
%     w = 1e-1;
% elseif length(varargin) == 2
%     lambda = varargin{1}; % lambda es el primer arg
%     kt = varargin{2}; % kt es el segundo arg
%     w = 1e-1;
% else
%     lambda = varargin{1};
%     kt = varargin{2};
%     w = varargin{3};
% end
% 
% % n=-N/2:N/2-1;
% % omega=2*pi/(b-a)*n;
% q0 = pi*w^2/lambda;
% z = z*q0; % Rayleigh length units
% 
% % Clase 20 mar
% Nx = 1;
% deltak = 
% kx = (-N/2:N/2)'.*deltak;
% ky = kx;
% 
% kz2 = (2*pi/lambda)^2-kt'*kt;
% k = 2*pi/lambda;
% U0 = E0/sqrt(2*pi);
% U0_hat = fft2(U0);
% U = ifft2(fftshift(U0_hat.*exp(1j*kz2.*z)))./(1j.*z*lambda);
% % Final output
% % E = exp(1j*k*z).*U./(1j*lambda*z);
% E = U;
% end

% function [Uout x2 y2] ...
%     = one_step_prop(Uin, wvl, d1, Dz)
% % function [x2 y2 Uout] ...
% %   = one_step_prop(Uin, wvl, d1, Dz)
% N = size(Uin, 1); % assume square grid
% k = 2*pi/wvl; % optical wavevector
% % source-plane coordinates
% [x1 y1] = meshgrid((-N/2 : 1 : N/2 - 1) * d1); % observation-plane coordinates
% [x2 y2] = meshgrid((-N/2 : N/2-1) / (N*d1)*wvl*Dz);
% % evaluate the Fresnel-Kirchhoff integral 
% Uout = 1 / (1j*wvl*Dz) ...
% .* exp(1j * k/(2*Dz) * (x2.^2 + y2.^2)) ... 
% .* fft2(Uin .* exp(1j * k/(2*Dz) ...
% * (x1.^2 + y1.^2)), d1);
% end