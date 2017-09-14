% 1D Heat Eqaution using FTCS

% Initalizing given variables/ data
% stability constant (c), dt = timesteps (k), dx = space steps (h)
% cfl = stability factor, it should be <= 1/2

clear;         % Clear the screen
c = 1/4;
dx = 0.1;
dt = 0.02;
cfl = c * dt/dx^2;

    x = 0:dx:1-dx;          % 
    t = 0:dt:2-dt;
    row = length(t);
    col = length(x);
    u = zeros(row,col);
    
    % Initial Condition
    
    for k = 1:length(x)
        u(1,k) = 100;
    end
    
    % Boundary Conditions
    % u(t,0) = 0, u(t,1) = 0
    
    u(:,1) = 0;
    u(:,end) = 0;
    
    % Loop to calucate u(n+1,i) given three values u(i,n), 
    % u(n,i+1) and u(n,i-1) from previous row.
    
    for n = 1:row-1         % row = 100
        for i = 2:col-1     % col = 10
            u(n+1,i) = u(n,i) + cfl * u(n,i+1) + cfl * u(n,i-1) - 2 * cfl * u(n,i);
        end
    end
    
    % Ploting the graph 

steps = row;
for step = 1:steps
   plot(x,u(step,:))
   xlim([0 1])                                       % limits for x-axis
   ylim([0 2])                                       % limits for y-axis
   title('Numerical Solution for 1D Heat Equation')  % Title 
   xlabel('Space')                                   % x-axis label
   ylabel('Time')                                    % y-axis label
   grid on
   drawnow
end

imagesc(u)                  % Image with scaled colors in xy plane
% surf(u)                   % Surface plot