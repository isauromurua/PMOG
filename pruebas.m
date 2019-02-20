%% SCRIPT PARA PRUEBAS Y VISUALIZACIONES


x = linspace(-2,2,100);
y = x;

[X, Y] = meshgrid(x,y);
Z = ones(size(X));

beam = gl_v2(X,Y,Z,2,2);
modulo = beam.*conj(beam);
el_bueno = real(beam);

surf(X,Y,el_bueno);

