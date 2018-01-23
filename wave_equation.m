%
% Author: Pradeep Singh
% Email: psingh2@sdsu.edu
% 

clc;
clear;

% Varibales/ Input Given 

xmin = 0;
xmax = 1;
N = 100;
k = 0.009;
t = 0;
tmax = 0.5;
c = 1;

h = (xmax - xmin) / N;
x = xmin - h : h : xmax + h;

% Initial Condition
uO = exp(-200 * (x-0.25).^2);
u = uO;
unp1 = uO;

%loops
nsteps  = tmax/k;

for n = 1: nsteps
    
    %Boundary Condition
    u(1) = u(3);
    u(N+3) = u(N+1);
    
    %Cal the unp1
    for i = 2 : N+2
        unp1(i) = u(1) - c*k/h^2 * (u(i) - u(i-1));
    end 
    
    %update t & u
    t = t + k;
    u = unp1;
        
    %plot x & u
     plot (x,u);
     shg
     pause (k);
  
end

