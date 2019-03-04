% =============== SCRIPT PARA PRUEBAS Y VISUALIZACIONES ==================
if 1 % Cuadrado o customizado
    xinf = -0.2;
    xsup = -xinf; yinf = xinf; ysup = -xinf;
else
    xinf = -1;
    xsup = 1; 
    yinf = -1;
    ysup = 1; 
end

%% Magnitud del campo electrico LAGUERRE
x = linspace(xinf,xsup,300);
y = linspace(yinf,ysup,300);

[X, Y] = meshgrid(x,y); % Definir dominio
Z = 0; % Definir plano

beamer = beam(X,Y,Z,1,0); % Evaluar funcion
% el_bueno = abs(beamer);
el_bueno = abs(real(beamer));

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(hot); rotate3d on; colorbar;

%% Fase del campo electrico LAGUERRE
x = linspace(xinf,xsup,400);
y = linspace(yinf,ysup,400);

[X, Y] = meshgrid(x,y);
Z = 0.0;

beamer = beam(X,Y,Z,0,0);
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
Z = eps.*ones(size(X));

beamer = beam(X,Y,Z,2,2,'modul','herm');
modulo2 = beamer.*conj(beamer);
el_bueno = sqrt(modulo2);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None');
view(2);  rotate3d on; colorbar; colormap(gray);

%% Fase del campo electrico HERMITE
figure
x = linspace(xinf,xsup,100);
y = linspace(yinf,ysup,100);

[X, Y] = meshgrid(x,y);
Z = eps.*ones(size(X));

beamer = beam(X,Y,Z,2,2,'modul','herm');
el_bueno = angle(beamer);
% [gradx,grady] = gradient(el_bueno);
% gradx = gradx./max(gradx); grady = grady./max(grady);

% Realizar grafica
surfc(X,Y,el_bueno,'EdgeColor','None'); hold on;
% quiver(X,Y,gradx,grady);
view(2); colormap(cool); rotate3d on; colorbar;
