close all
% Load ray data
load('lightField.mat');

% Render image using rays2img
sensorWidth = 0.015; 
numPixels = 1000;
d2=0.4;
for d1=0.38:0.001:0.42
        f=d2*d1/(d2+d1);
        Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1]; 
        Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];
        raysImaged = Md2*Mf*rays;
        [img,~,~] = rays2img(raysImaged(1,:),raysImaged(3,:),sensorWidth,numPixels);
        figure; 
        img=flip(img, 2); 
        imshow(img); 
        axis image; 
        title(" d1: "+d1+" f: "+f);
end
