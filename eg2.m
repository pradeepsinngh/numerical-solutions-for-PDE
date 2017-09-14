% 1D Heat Eqaution using FTCS

% Initalizing given variables/ data
% stability constant (c), dt = timesteps (k), dx = space steps (h)
% cfl = stability factor, it should be <= 1/2

clear;         % Clear the screen
c = .25;
dx = 0.1;
dt = 0.02;
cfl = c * dt/dx^2;

    x = 0:dx:1-dx;
    t = 0:dt:2-dt;
    row = length(t);
    col = length(x);
    U = zeros(row,col);
    
    % Initial Condition
    
    for k = 1:length(x)
        U(1,k) = 100;
    end
    
    % Boundary Condition
    
    U(:,1) = 0;
    U(:,end) = 0;
    
    %Loop
    for n = 1:row-1         % row = 100
        for i = 2:col-1     % col = 10
        %for n = 1:row
           U(n+1,i) = U(n,i) + cfl * U(n,i+1) + cfl * U(n,i-1) - 2 * cfl * U(n,i);
        end
    end

    plot (x,U)
    xlim([0 1])
    ylim([0 2])
    
%W = flipud(U);

steps = row;
for step = 1:steps
   plot(x,U(step,:))
   xlim([0 1])
   ylim([0 2])
    drawnow
    grid on
end

imagesc(U)