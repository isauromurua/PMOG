% =============== SCRIPT PARA PRUEBAS Y VISUALIZACIONES ==================

%% Magnitud del campo electrico
x = linspace(-2,2,400);
y = x;

[X, Y] = meshgrid(x,y);
Z = 0.01.*ones(size(X));

beamer = beam(X,Y,Z,1,2);
modulo = beamer.*conj(beamer);
el_bueno = sqrt(modulo);

surf(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;

%% Fase del fasor
x = linspace(-2,2,400);
y = x;

[X, Y] = meshgrid(x,y);
Z = ones(size(X));

beamer = beam(X,Y,Z,1,2);
el_bueno = angle(beamer);

surf(X,Y,el_bueno,'EdgeColor','None');
view(2); colormap(gray); rotate3d on; colorbar;



%% 
