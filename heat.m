clear; 
c = .25;
h = 0.1;  % Change in x
k = 0.02; % Change in t
cfl = c*k/h^2; %stability condition

    x = [0:h:1];
    t = [0:k:2];
    row = length(x);
    col = length(t);
    U = ones(row,col) * 100;
  
    % Boundary Condition
   
    U(:,end) = 0;
    U(:,1) = 0;
    
    
    for n = 2:row-1
        for i = 1:col-1
            U(i+1,n) = U(i,n) + cfl*(U(i+1,n) + U(i-1,n) - 2*U(i,n));
        end
    end

    
W = flipud(U);
h = waitbar(0,'Please wait...');
steps = row;
for step = 1:steps
    plot(x,U(step,:))
    xlim([0 1])
    ylim([0 10])
    drawnow
    grid on
    text('Position',[0.5 1],'String',dt*step,'FontSize',41   )
    text('Position',[0.1 1],'String','Time','FontSize',41   )
    waitbar(step / steps)
end
close(h)
figure(2)
mesh(W)
    
    plot(x,U)
    