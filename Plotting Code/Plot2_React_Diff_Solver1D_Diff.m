function [] = Plot2_React_Diff_Solver1D_Diff( u,x,t,L,u1,x1,t1,L1 )
%Plot_React_Diff_Solver1D_Diff Plots the diffusion solution

% Plot numerical method
figure(2)

for i = 1:length(t)
    subplot(1,2,1)
    plot(x,u(:,i))
    axis([0 L 0 0.35]);
    ylabel('Concentration');
    xlabel('Wafer,Water,Brain');
    
    subplot(1,2,2)
    plot(x1,u1(:,i))
    axis([0 L1 0 0.35]);
    ylabel('Concentration');
    xlabel('Wafer,Water,Brain');
    pause(0.01)
    if i == 1
        pause
    end
end


end
