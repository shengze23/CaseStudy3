clear all;
close all;
theta_x1 = linspace(-pi/20, pi/20, 8);
theta_x2 = linspace(-pi/20, pi/20, 8);
x2=zeros(1,8);
x2(1,:)=1;
points1=[zeros(1,8); theta_x1; zeros(1,8); zeros(1,8)]; 
points2=[x2;theta_x2;zeros(1,8);zeros(1,8)];

d=20;

M_d=[1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

rays_out_1=zeros(4,8);
rays_out_2=zeros(4,8);

for i=1:length(points1)
    rays_out_1(:,i)=M_d*points1(:,i);
    rays_out_2(:,i)=M_d*points2(:,i);
end

figure;
hold on;
ray_z_1 = [zeros(1, size(points1, 2)); d * ones(1, size(points1, 2))];
ray_z_2 = [zeros(1, size(points2, 2)); d * ones(1, size(points2, 2))];
plot(ray_z_1, [points1(1,:); rays_out_1(1,:)],'r');
plot(ray_z_2, [points2(1,:); rays_out_2(1,:)],'b');
hold off;

radius=2;
f=10;
M_f=[1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
count1=1;
count2=1;
remaining_rays_1=zeros(4,1);
remaining_rays_2=zeros(4,1);
for i=1:length(points2)
    if abs(rays_out_1(1,i))<= radius
        remaining_rays_1(:,count1)=rays_out_1(:,i);
        count1=count1+1;
    end
    if abs(rays_out_2(1,i))<=radius
        remaining_rays_2(:,count2)=rays_out_2(:,i);
        count2=count2+1;
    end
end

for i=1:count1-1
    remaining_rays_1(:,i)=M_f*remaining_rays_1(:,i);
end
for i=1:count2-1
    remaining_rays_2(:,i)=M_f*remaining_rays_2(:,i);
end

d2=20;
M_d2=[1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

rays_out_3=zeros(4,4);
rays_out_4=zeros(4,4);
for i=1:count1-1
    rays_out_3(:,i)=M_d2*remaining_rays_1(:,i);
    rays_out_4(:,i)=M_d2*remaining_rays_2(:,i);
end

figure;
hold on;
ray_z_3 = [d*ones(1,size(remaining_rays_1,2));(d2+d*ones(1,size(remaining_rays_1,2)))];
ray_z_4 = [d*ones(1,size(remaining_rays_2,2));(d2+d*ones(1,size(remaining_rays_2,2)))];
plot(ray_z_1, [points1(1,:); rays_out_1(1,:)],'r');
plot(ray_z_2, [points2(1,:); rays_out_2(1,:)],'b');
plot(ray_z_3,[remaining_rays_1(1,:);rays_out_3(1,:)],"Color",'r');
plot(ray_z_4,[remaining_rays_2(1,:);rays_out_4(1,:)],"Color",'b');
hold off;












%theta_y1 = 0;

% Propagation distance
%d = 150; % mm


% Assemble input rays
%rays_in = [x1 * ones(1, length(theta_x1)); theta_x1; y1 * ones(1, length(theta_x1)); theta_y1 * ones(1, length(theta_x1))];

% Free space propagation matrix
%M_d = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];


% Propagate rays 
%rays_out = M_d * rays_in;

% Plot ray diagram
%figure;
%ray_z = [zeros(1, size(rays_in, 2)); d * ones(1, size(rays_in, 2))];
%plot(ray_z, [rays_in(1, :); rays_out(1, :)], '-o') % Plotting rays with markers
%xlabel('z (mm)');
%ylabel('x (mm)');
%title('Ray Diagram');
