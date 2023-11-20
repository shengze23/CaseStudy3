clear
close all
load lightField.mat


sensorWidth = 0.015;
numPixels = 800;

d1 = 0.4;

f = 0.2;

d2 = 0.4;

[rays_x,rays_y] = propRays(d1,d2,f,rays);

img = rays2img(rays_x,rays_y,sensorWidth,numPixels);

figure;
imshow(flip(img,2))
title('seperated image')
%% 
% Using Kmeans to cluster the rays that produce the three different images
xPos = rays(1,:);
yPos = rays(3,:);

Pos = [xPos;yPos];

k = 3;

[idx,C] = kmeans(Pos',k);

rays_1 = rays(:,idx==1);
rays_2 = rays(:,idx==2);
rays_3 = rays(:,idx==3);

[x1,y1] = propRays(d1,d2,f,rays_1);
[x2,y2] = propRays(d1,d2,f,rays_2);
[x3,y3] = propRays(d1,d2,f,rays_3);


img1 = rays2img(x1,y1,sensorWidth,numPixels);
img2 = rays2img(x2,y2,sensorWidth,numPixels);
img3 = rays2img(x3,y3,sensorWidth,numPixels);


figure;
imshow(flip(img1,2));
exportgraphics(gca,'img1.jpg','Resolution',600)
figure;
imshow(flip(img2,2));
exportgraphics(gca,'img2.jpg','Resolution',600)
figure;
imshow(flip(img3,2));
exportgraphics(gca,'img3.jpg','Resolution',600)
%% 


