clear;
close all;



% Defining initial parameters
x1 = 10;
x2 = 20;
y1 = 0;
y2 = 0;

theta_x1 = linspace(-pi/30,pi/30,10);
theta_x2 = linspace(-pi/30,pi/30,10);



d1 = 200;

d2 = 600;

f = 150;


% Initial Ray, 
%red rays
ray_in_1 = [x1*ones(1,10); theta_x1; zeros(1,10); zeros(1,10)];

%blue rays
ray_in_2 = [x2*ones(1,10); theta_x2; zeros(1,10); zeros(1,10)];

% Transition matrix for d1
M_d1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];

% Transition matrix for f - lens
M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

% Transition matrix for d2
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% initialize for ray out before lens
ray_d1_1 = zeros(4,10);
ray_d1_2 = zeros(4,10);


% compute the position of rays right before the lens
for i = 1:length(ray_d1_1)
    ray_d1_1(:,i) = M_d1 * ray_in_1(:,i);
    ray_d1_2(:,i) = M_d1 * ray_in_2(:,i);
end

%plotting the rays and the lens before crossing


% rays in z
ray_z_d1_1 = [zeros(1,size(ray_in_1,2)); d1*ones(1,size(ray_in_1,2))];
ray_z_d1_2 = [zeros(1,size(ray_in_2,2)); d1*ones(1,size(ray_in_2,2))];

%lens
radius_lens = 20;
lens_x = 15;
%the lens
pos = [d1-radius_lens lens_x-radius_lens 2*radius_lens 2*radius_lens];

figure;
hold on;
plot(ray_z_d1_1, [ray_in_1(1,:); ray_d1_1(1,:)],"Color",'red');
plot(ray_z_d1_2, [ray_in_2(1,:); ray_d1_2(1,:)],'Color','blue');
rectangle('Position', pos, 'Curvature', [1, 1], 'EdgeColor', 'k');
xlabel('z (mm)');
ylabel('x (mm)');
title('Rays before lens')
hold off;


% -----------Compute the final position of rays after the lens

% only count the rays that cross the lens
rays_lens_1 = [];
rays_lens_2 = [];

%if the difference is within the radius of the lens
for i = 1: length(ray_d1_1)
    if abs(ray_d1_1(1,i)-lens_x) < radius_lens
        rays_lens_1 = [rays_lens_1 ray_d1_1(:,i)];
    end
    if abs(ray_d1_2(1,i)-lens_x) < radius_lens
        rays_lens_2 = [rays_lens_2 ray_d1_2(:,i)]; 
    end
end

% compute the bend by lens

rays_f_1 = zeros(4,length(rays_lens_1));
rays_f_2 = zeros(4,length(rays_lens_2));

for i = 1:length(rays_lens_1)
    rays_f_1(:,i) = M_f * rays_lens_1(:,i);
end

for i = 1:length(rays_lens_2)
    rays_f_2(:,i) = M_f * rays_lens_2(:,i);
end

% compute final position

rays_out_1 = zeros(4,length(rays_f_1));
rays_out_2 = zeros(4,length(rays_f_2));

for i = 1:length(rays_f_1)
    rays_out_1(:,i) = M_d2 * rays_f_1(:,i);
end
for i = 1:length(rays_f_2)
    rays_out_2(:,i) = M_d2 * rays_f_2(:,i);
end

%plotting the whole thing

rays_zf_1 = [d1 * ones(1, size(rays_lens_1, 2));
    (d2 + d1) * ones(1, size(rays_lens_1, 2))];

rays_zf_2 = [d1 * ones(1, size(rays_lens_2, 2));
    (d2 + d1) * ones(1, size(rays_lens_2, 2))];

figure;
hold on;
plot(ray_z_d1_1, [ray_in_1(1,:); ray_d1_1(1,:)],"Color",'red');
plot(ray_z_d1_2, [ray_in_2(1,:); ray_d1_2(1,:)],"Color",'blue');
rectangle('Position', pos, 'Curvature', [1, 1], 'EdgeColor', 'k');
plot(rays_zf_1, [rays_lens_1(1,:);rays_out_1(1,:)],"Color",'red');
plot(rays_zf_2, [rays_lens_2(1,:);rays_out_2(1,:)],'Color','blue');
xlabel('z (mm)');
ylabel('x (mm)');
title('Rays')
hold off;


















