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