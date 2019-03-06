% =============== SCRIPT PARA PRUEBAS Y VISUALIZACIONES ==================
xinf = -10;
xsup = 10;
yinf = -10;
ysup = 10;

%% Magnitud del campo electrico LAGUERRE
x = linspace(xinf,xsup,4000);
y = linspace(yinf,ysup,4000);

[X, Y] = meshgrid(x,y); % Definir dominio
Z = eps.*ones(size(X)); % Definir plano

beamer = beam(X,Y,Z,2,2); % Evaluar funcion
% el_bueno = abs(beamer);
el_bueno = abs(real(beamer));

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;

%% Fase del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
Z = 0.001.*ones(size(X));

beamer = beam(X,Y,Z,8,100);
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
view(2);  rotate3d on; colorbar; colormap(gray);
view(2);  rotate3d on; colorbar; colormap(gray);

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
view(2); colormap(cool); rotate3d on; colorbar;
