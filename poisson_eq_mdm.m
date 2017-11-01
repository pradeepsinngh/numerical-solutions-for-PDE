%% 2D Poisson Equation

% Author: Pradeep Singh
% Email: psingh2@sdsu.edu

% Numerical Solution for 2D Poisson Equation 
% using Mimetic Discretization Method (MDM)

%% Getting Started

clear; clc  % clear workspace

addpath('../Matlab/mole-master/mole_MATLAB') % path of mole library

%% Inputs

m = 10;  % grid points
n = 10;  % grid points
a = 0;  % West
b = 1;  % East
c = 0;  % South
d = 1;  % North
dx = (b-a)/m;  % Step length along the x-axis
dy = (d-c)/n;  % Step length along the y-axis
k = 2;

%% Laplacian Mattix (L)

% Initalize Matrices, with zeros and identity matrix

Q = zeros(144,144) + eye(144,144);

% Using two-dimensional mimetic laplacian operator
% we got a L matrix

L = lap2D(k, m, dx, n, dy);
L = L + Q;

%% Z Matrix

% z matrix to compute f matrix

n = 12;              % n = number of grid points
z = zeros(n,n);      % square matrix to compute f matrix

x = linspace(0,1,12);  % x axis with n grid points
y = linspace(0,1,12);  % y axis with m gridd points

%% Boundary Condition

z(1,:) = 0;   % zero on 1st row
z(n,:) = 0;   % zero on last row
z(:,1) = 0;   % zero on 1st col
z(:,n) = 0;   % zero on last col

%% Calculate Z matrix 

% for loop from 2nd row and 2nd col till (h-1) row and 
% column to compute z(i,j)

for i = 2:1:n-1             % row 
    for j = 2:1:n-1         % col    
           z(i,j) = 2*(i+j)-2*(i^2 + j^2);
    end
end

%% Calculate f matrix

% For loop to arrange all elements of z matrix in 
% column vector format

m = 1;
for i = 1:1:n             % row 
   for j = 1:1:n          % col
           f(m,1) = z(i,j);
           m = m+1;
   end
end

%% U matrix (Numerical Solution)

% Caculate "U" (Numerical solution) uisng "\"(backslash) operator.

U = L\f;

% Convert U vector array in matrix format of size (n x m),
% to plot the result

B = reshape(U,[n,n]);

%% Plots
% Plot surface image of the B matrix

surf(x,y,B)
title('Numerical Solution for 2D Poisson Equation')  % Title 
xlabel('x axis')                                     % x-axis label
ylabel('y axis')                                     % y-axis label
zlabel('U(x,y)')                                     % z-axis label
grid on

%% Conclusion

% We plotted Numerical Solution for 2D Poisson Equation using 
% Mimetic Discretization Method (MDM). 
% It can be noted that, with MDM's computing Laplacian matrix (L) 
% is pretty straight forward and can be done just using some commands.
