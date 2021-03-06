function [] = Plot_React_Diff_Solver1D_Diff2( u,x,t )
%Plot_React_Diff_Solver1D_Diff Plots the diffusion solution

% Plot numerical method
figure(1)

for i = 1:length(t)
    plot(x,u(:,i)) 
    hold on 
%     plot(y,v(:,i))
    axis([0 x(end) 0 0.35]);
    ylabel('Concentration');
    xlabel('Water,Wafer,Water,Brain');
    hold off
    pause(0.01);
end


end
