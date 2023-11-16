clear all;
close all;

% Initialization
theta_x1 = linspace(-pi/20, pi/20, 8);
theta_x2 = linspace(-pi/20, pi/20, 8);
x2 = zeros(1, 8);
x2(1, :) = 1;
points1 = [zeros(1, 8); theta_x1; zeros(1, 8); zeros(1, 8)]; % initial points 1
points2 = [x2; theta_x2; zeros(1, 8); zeros(1, 8)]; % initial points 2
d = 20;

% Transformation matrices
M_d = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1]; %md1 matrix
M_f = [1 0 0 0; -1/10 1 0 0; 0 0 1 0; 0 0 -1/10 1];%mf matrix represent lens
d2 = 20;
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];%md2 matrix

% Applying transformations to rays
rays_out_1 = zeros(4, 8);
rays_out_2 = zeros(4, 8);

for i = 1:length(points1) %compute Md1*vector
    rays_out_1(:, i) = M_d * points1(:, i);
    rays_out_2(:, i) = M_d * points2(:, i);
end

% Plotting rays
figure;
hold on;
ray_z_1 = [zeros(1, size(points1, 2)); d * ones(1, size(points1, 2))];
ray_z_2 = [zeros(1, size(points2, 2)); d * ones(1, size(points2, 2))];
plot(ray_z_1, [points1(1, :); rays_out_1(1, :)], 'r');
plot(ray_z_2, [points2(1, :); rays_out_2(1, :)], 'b');
radius_lens = 2; % Radius of the lens
center_x = 20; % X-coordinate of the lens center
rectangle('Position', [center_x - radius_lens, -radius_lens, 2 * radius_lens, 2 * radius_lens], 'Curvature', [1, 1], 'EdgeColor', 'k');
hold off;

radius = 2;
count1 = 1;
count2 = 1;
remaining_rays_1 = zeros(4, 1);
remaining_rays_2 = zeros(4, 1);

%check condition if the ray is inside of the circle
for i = 1:length(points2)
    if abs(rays_out_1(1, i)) <= radius
        remaining_rays_1(:, count1) = rays_out_1(:, i);
        count1 = count1 + 1; %cound the valid # of light
    end
    if abs(rays_out_2(1, i)) <= radius
        remaining_rays_2(:, count2) = rays_out_2(:, i);
        count2 = count2 + 1;
    end
end

% transformation of the lights valid in the circle
for i = 1:count1 - 1
    remaining_rays_1(:, i) = M_f * remaining_rays_1(:, i);
end

for i = 1:count2 - 1
    remaining_rays_2(:, i) = M_f * remaining_rays_2(:, i);
end

% Applying another transformation and plotting rays after refraction
rays_out_3 = zeros(4, 4);
rays_out_4 = zeros(4, 4);

for i = 1:count1 - 1
    rays_out_3(:, i) = M_d2 * remaining_rays_1(:, i);
end

for i = 1:count2 - 1
    rays_out_4(:, i) = M_d2 * remaining_rays_2(:, i);
end

%plot graph
figure;
hold on;
ray_z_3 = [d * ones(1, size(remaining_rays_1, 2)); (d2 + d) * ones(1, size(remaining_rays_1, 2))];
ray_z_4 = [d * ones(1, size(remaining_rays_2, 2)); (d2 + d) * ones(1, size(remaining_rays_2, 2))];
plot(ray_z_1, [points1(1, :); rays_out_1(1, :)], 'r');
plot(ray_z_2, [points2(1, :); rays_out_2(1, :)], 'b');
plot(ray_z_3, [remaining_rays_1(1, :); rays_out_3(1, :)], 'Color', 'r');
plot(ray_z_4, [remaining_rays_2(1, :); rays_out_4(1, :)], 'Color', 'b');
radius_lens = 2; % Radius of the lens
center_x = 20; % X-coordinate of the lens center
rectangle('Position', [center_x - radius_lens, -radius_lens, 2 * radius_lens, 2 * radius_lens], 'Curvature', [1, 1], 'EdgeColor', 'k');
hold off;
