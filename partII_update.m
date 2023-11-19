clear;
close all;

load lightField.mat


%% 

% Initialize 

sensorWidth = 0.01;
numPixels = 800;

rays_x = rays(1,:);
rays_y = rays(3,:);

%
image = rays2img(rays_x,rays_y,sensorWidth,numPixels);

% Display the image
figure;
imshow(image);
title('First render');



d1 = 0.4;
d2 = 0.4;
f = 0.2;

[rays_x,rays_y] = propRays(d1,d2,f,rays);

img1 = rays2img(rays_x,rays_y,sensorWidth,numPixels);
figure;
imshow(flip(img1,2))
axis image
title('test')


%% 
d2 = 0.4;
for d1 = 0.35 : 0.01 : 0.45
    f = d2*d1/(d1+d2);
    
    [rays_x,rays_y] = propRays(d1,d2,f,rays);
    
    img = rays2img(rays_x,rays_y,sensorWidth,numPixels);
    figure;
    imshow(flip(img,2))
    axis image
    title("d1:"+d1+"f:"+f)
end


%% 

function [rays_outX,rays_outY] = propRays(d1,d2,f,rays)

    % Transition Matrix for D2
    M_d2 = [1    d2  0   0; 
            0    1   0   0;
            0    0   1   d2;
            0    0   0   1];

    % Lens
    M_f = [1        0           0           0;
           -1/f     1           0           0;
           0        0           1           0;
           0        0           -1/f        1];

    %Propagate
    rays_out = M_d2 * M_f * rays;

    % Extracting the X and Y rays
    rays_outX = rays_out(1,:);
    rays_outY = rays_out(3,:);

end