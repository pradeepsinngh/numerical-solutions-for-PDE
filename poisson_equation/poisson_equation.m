%
% File Name: poisson_equation.m
% Author: Pradeep Singh
% Date: 9/27/2017
% Language: Matlab
% Description: % Numerical Solution for 2D Poisson Equation using matrix vector multiplication.
%

clear; clc  % clear workspace

% Inputs

Nx = 10;  % grid points
Ny = 10;  % grid points
Lx = 1;   % x axis [0,1], lenght of x axis
Ly = 1;   % y axis [0,1], length of y axis

x = linspace(0,Lx,Nx);  % x axis with Nx gird points
y = linspace(0,Ly,Ny);  % y axis with Ny gird points

h = .1;                 % space between two grid points

% Initalize Matrices

N = Nx * Ny;                % No of unknowns
L = zeros(N,N) + eye(N);    % Get the L matrix by using eye function

% Laplace matrix (L)
% Using for loop to get L matrix. 
% L matrix will be used to compute U(i,j) on interior grid points

for i=2:Nx-1
    for j=2:Ny-1
        n=i+(j-1)* Nx;
        L(n,n)= -4/h^2;
        L(n,n-1)= 1/h^2;
        L(n,n+1) = 1/h^2;
        L(n,n-Nx)= 1/h^2;
        L(n,n+Nx)= 1/h^2;
    end
end

% z matrix to compute f matrix

n = 10;              % n = number of grid points
z = zeros(n,n);      % square matrix to compute f matrix

% Boundary Condition

z(1,:) = 0;   % zero on 1st row
z(n,:) = 0;   % zero on last row
z(:,1) = 0;   % zero on 1st col
z(:,n) = 0;   % zero on last col

% Calculate z matrix 
% for loop from 2nd row and 2nd col till (h-1) row and 
% column to compute z(i,j)

for i = 2:1:n-1             % row 
    for j = 2:1:n-1         % col    
           z(i,j) = 2*(i+j)-2*(i^2 + j^2);
    end
end

% Calculate f matrix
% For loop to arrange all elements of z matrix in 
% column vector format

m = 1;
for i = 1:1:n             % row 
   for j = 1:1:n          % col
           f(m,1) = z(i,j);
           m = m+1;
   end
end

% U matrix (Numerical Solution)
% Caculate "U" (Numerical solution) uisng "\"(backslash) operator.

U = L\f;

% Numerical solution in matrix format
% Convert U vector array in matrix format of size (Nx x Ny),
% to plot the result

B = reshape(U,[10,10]);

% Plots
% Plot surface image of the B matrix

surf(x,y,B)
title('Numerical Solution for 2D Poisson Equation')  % Title 
xlabel('x axis')                                     % x-axis label
ylabel('y axis')                                     % y-axis label
zlabel('U(x,y)')                                     % z-axis label
grid on

% that's all folks %
