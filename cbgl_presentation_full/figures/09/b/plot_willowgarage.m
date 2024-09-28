clear all
close all
pkg load io
pkg load geometry
graphics_toolkit("gnuplot")

here = '/home/li9i/Desktop/cbgl_presentation_iros24/figures/09/b';

% map
map_str = strcat(here, '/willowgarage');
ms = csv2cell(map_str);
map_x = ms(2:end, 1);
map_y = ms(2:end, 2);
map_x = cell2mat(map_x);
map_y = cell2mat(map_y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 200 200])



M = [map_x map_y];




plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");

axis equal
axis([45 90 35 81]);

img_file = strcat(here, '/map_willowgarage.eps');
drawnow ("epslatex", img_file, '')
