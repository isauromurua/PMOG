% =============== SCRIPT PARA PRUEBAS Y VISUALIZACIONES ==================
if 1 
    xsup = 0.4; 
    xinf = -xsup;
    ysup = -xsup; yinf = --xsup;
else
    xinf = -2;
    xsup = 2;
    yinf = -2;
    ysup = 2;
end
%% Magnitud del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y); % Definir dominio
z = 3; % Definir plano

beamer = LGBeam(1,1,1e-1,X,Y,z);
% beamer = beam(X,Y,Z,2,2,'w0',0.1e-0); % Evaluar funcion
% el_bueno = abs(beamer);
el_bueno = abs((beamer));

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;

%% ANIMACION AMPLITUD

frames = 100;
max = 100;
beamer = zeros(400,400,frames);
el_bueno = zeros(400,400,frames);
for l = 1:frames
    beamer(:,:,l) = LGBeam(2,2,1e-1,X,Y,max*(l-1)/(frames));
    el_bueno(:,:,l) = abs(real(beamer(:,:,l)));
end

for l = 1:frames
    % Realizar grafica
    surfc(X,Y,el_bueno(:,:,l),'EdgeColor','None');
    view(2); colormap(gray); rotate3d on; colorbar;
    pause(0.01);
end
%% Fase del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
z = 1;

beamer = LGBeam(1,1,1e-1,X,Y,z);
el_bueno = angle(beamer);
% [gradx,grady] = gradient(el_bueno);
% gradx = gradx./max(gradx); grady = grady./max(grady);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None'); hold on;
% quiver(X,Y,gradx,grady);
view(2); colormap(gray); rotate3d on; colorbar;

%% ANIMACION FASE

frames = 100;
max = 100;
beamer = zeros(400,400,frames);
el_bueno = zeros(400,400,frames);
for l = 1:frames
    beamer(:,:,l) = LGBeam(2,2,1e-1,X,Y,max*(l-1)/(frames));
    el_bueno(:,:,l) = angle((beamer(:,:,l)));
end

for l = 1:frames
    % Realizar grafica
    surfc(X,Y,el_bueno(:,:,l),'EdgeColor','None');
    view(2); colormap(gray); rotate3d on; colorbar;
    pause(0.01);
end

%% Magnitud del campo electrico HERMITE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
z = eps;

beamer = beam(X,Y,z,5,5,'modul','herm','w0',1e-1);
modulo2 = beamer.*conj(beamer);
el_bueno = sqrt(modulo2);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;
view(2);  rotate3d on; colorbar; colormap(gray);
view(2);  rotate3d on; colorbar; colormap(gray);

%% Fase del campo electrico HERMITE
figure
x = linspace(xinf,xsup,100);
y = linspace(yinf,ysup,100);

[X, Y] = meshgrid(x,y);
z = 0;

beamer = beam(X,Y,z,5,5,'modul','herm');
el_bueno = angle(beamer);
% [gradx,grady] = gradient(el_bueno);
% gradx = gradx./max(gradx); grady = grady./max(grady);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None'); hold on;
% quiver(X,Y,gradx,grady);
view(2); colormap(gray); rotate3d on; colorbar;
