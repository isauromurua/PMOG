%% SCRIPT PARA PRUEBAS Y VISUALIZACIONES


x = linspace(-2,2,100);
y = x;

[X, Y] = meshgrid(x,y);
Z = ones(size(X));

beamer = beam(X,Y,Z,1,2);
modulo = beamer.*conj(beamer);
el_bueno = sqrt(modulo);

surf(X,Y,el_bueno);
