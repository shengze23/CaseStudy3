close all;
clear all;

% Load ray data
load('lightField.mat');

% Render image using rays2img
sensorWidth = 0.015; 
numPixels = 1000;
[img,~,~] = rays2img(rays(1,:),rays(3,:),sensorWidth,numPixels);
figure; imshow(img); axis image; title('Raw rays'); 

% Propagate rays by distance d
d = 0.4; % propagation distance
Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
raysProp = Md * rays; 

% Render propagated rays
[img,~,~] = rays2img(raysProp(1,:),raysProp(3,:),sensorWidth,numPixels);
figure; imshow(img); 
axis image; 
title('Propagated rays');

% Imaging system parameters
f = 54/215; 
d2 = 0.675;

% Ray transfer matrices
Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1]; 
Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% Apply imaging system to rays
raysImaged = Md2*Mf*rays;  

% Render imaged rays
[img,~,~] = rays2img(raysImaged(1,:),raysImaged(3,:),sensorWidth,numPixels);
figure; 
img=flip(img, 2); 
imshow(img); 
axis image; 
title('Imaged rays');
