% =============== SCRIPT PARA PRUEBAS Y VISUALIZACIONES ==================
xinf = -5;
xsup = 5;
yinf = -5;
ysup = 5;

%% Magnitud del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y); % Definir dominio
Z = eps.*ones(size(X)); % Definir plano

beamer = beam(X,Y,Z,15,4); % Evaluar funcion
modulo2 = beamer.*conj(beamer);
el_bueno = sqrt(modulo2);
% el_bueno = (real(beamer));

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(hot); rotate3d on; colorbar;

%% Fase del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
Z = 0.001.*ones(size(X));

beamer = beam(X,Y,Z,0,2);
el_bueno = angle(beamer);
% [gradx,grady] = gradient(el_bueno);
% gradx = gradx./max(gradx); grady = grady./max(grady);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None'); hold on;
% quiver(X,Y,gradx,grady);
view(2); colormap(gray); rotate3d on; colorbar;

%% Magnitud del campo electrico HERMITE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
Z = 0.01.*ones(size(X));

beamer = beam(X,Y,Z,2,2,'modul','herm');
modulo2 = beamer.*conj(beamer);
el_bueno = sqrt(modulo2);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;

%% Fase del campo electrico HERMITE
figure
x = linspace(xinf,xsup,100);
y = linspace(yinf,ysup,100);

[X, Y] = meshgrid(x,y);
Z = eps.*ones(size(X));

beamer = beam(X,Y,Z,1,1,'modul','herm');
el_bueno = angle(beamer);
% [gradx,grady] = gradient(el_bueno);
% gradx = gradx./max(gradx); grady = grady./max(grady);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None'); hold on;
% quiver(X,Y,gradx,grady);
view(2); colormap(gray); rotate3d on; colorbar;
