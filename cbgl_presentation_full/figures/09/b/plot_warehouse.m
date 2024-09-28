clear all
close all
pkg load io
pkg load geometry
graphics_toolkit("gnuplot")

here = '/home/li9i/Desktop/cbgl_presentation_iros24/figures/09/b';

% map
map_str = strcat(here, '/warehouse');
ms = csv2cell(map_str);
map_x = ms(2:end, 1);
map_y = ms(2:end, 2);
map_x = cell2mat(map_x);
map_y = cell2mat(map_y);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1, 'position', [1 1 150 250])

Rm = [0 -1; 1 0];
Rp = [0 -1 0; 1 0 0; 0 0 1];
M = [map_x map_y];
M = Rm * M';
M = M';

M(:,1) = M(:,1) + 21.0;
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

x = xlabel("$x$ [m]");
y = ylabel("$y$ [m]");

axis equal
axis([0 22 0 42])

img_file = strcat(here, '/map_warehouse.eps');
drawnow ("epslatex", img_file, '')
