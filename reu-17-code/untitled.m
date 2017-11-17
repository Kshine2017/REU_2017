close all
I = new1;
map = [];
[X,Y] = meshgrid(-100:100,-80:80);
Z = -(X.^2 + Y.^2);
warp(X,Y,Z,I,map);


% original = imread('normal_knee.jpg');
% original1 = imread('test_knee.jpg');
% original = new1;
% hold on 
% imshow(original)
% hold on 
% warp(original, original,' map')
 
% % original = images_slices;
% % [X,Y,Z] = ellipsoid(0,0,0,10,10,10);
% [X,Y] = ngrid(0:10, 0:10);
% % [X,Y,Z,V] = flow;
% figure;
% % xslice = 5;
% % yslice = 0;
% % zslice = 0;
% % slice(x,y,z,v,xslice,yslice,zslice);
% % axis([0 10 -4 4 -3 3]);
% grid off;
% 
% % surf(X,Y,Z)
surf(X, Y, original, 'edgecolor', 'none', 'FaceColor','texturemap')
% 
% h = findobj('Type', 'surface');
% set(h, 'CData', original, 'FaceColor', 'texturemap');
% % view(3);


