%% 1D One Way Wave Equation

% Solving 1D One Way Wave Equation using MDM.
% Author: Pradeep Singh
% Date: 10/30/2017

clc
close all

addpath('../Matlab/mole-master/mole_MATLAB') % path of mole library

%% Initial Given values 

% Domain values for x and t
x_min = -1;   
x_max = 1;    
t_min = 0; 
t_max = 1.2;
c = 1;      % c = 1 (given value)

k = 2;  % Operator's order of accuracy
m = 50; % Number of cells

% Step size in space and time direction
dx = (x_max-x_min)/m;  % step size in space
dt = (t_max-t_min)/m; % step size in time

t = 1.2; % Simulation time

%% Mimetic Discretization Method

D = div(k, m, dx); % 1D Mimetic divergence operator

% BC for divergence matrix
D(1,2) = 1/(2*dx);
D(1,end-1) = -1/(2*dx);
D(end,2) = 1/(2*dx);
D(end,end-1) = -1/(2*dx);
 
I = interpol(m, 0.5); % 1D 2nd order interpolator

D = -c*dt*2*D*I;


% 1D Staggered grid
x = [x_min x_min+dx/2: dx :x_max-dx/2 x_max];

%% Initial Condition
    
% Initial Condition
% u(x,0) = u0(x) = sin(2*pi*x)
U = sin(2*pi*x)'; % % time step one

% Compute for second time step
U2 = U + D/2*U; % second time step

%% Leap Frog Scheme

% Start from thrid time step
for i = 1 : t/dt
    U3 = U + D*U2; % Compute next step using Leapfrog scheme
    U = U2;
    U2 = U3;
end


%% Plot

% Plot the Analytical and FTCS solution
plot(x, U2)
hold on
plot(x, U) % Plot exact solution
hold off
axis([-1 1 -1 1])
str = sprintf('Solution at t = %.2f', 1.2);
title(str)
xlabel('x')
ylabel('u(x)')
legend('MDM','Analytical', 'Location', 'Southeast'); 

%% Discussion

% With Mimetic Discretization Methods, we get second order of accuracy.
    