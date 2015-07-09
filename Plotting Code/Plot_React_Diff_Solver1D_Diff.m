function [] = Plot_React_Diff_Solver1D_Diff( u1,x,u2,y,t )
%Plot_React_Diff_Solver1D_Diff Plots the diffusion solution
%Make sure y>x
% Plot numerical method
figure(1)

for i = 1:length(t)
%     subplot(1,2,1)
    plot(x,u1(:,i)) 
    axis([0 y(end) 0 0.2]);
    ylabel('Concentration');
    xlabel('Water,Wafer,Water,Brain');
    hold on
    
%     subplot(1,2,2)
    plot(y,u2(:,i))
    axis([0 y(end) 0 0.2]);
%     ylabel('Concentration');
%     xlabel('Water,Wafer,Water,Brain');


    hold off

%     subplot(2,2,3)
%     plot(x,u3(:,i))
%     axis([0 L 0 1]);
%     ylabel('Concentration');
%     xlabel('Water,Wafer,Water,Brain');
%     title('P=0.5');
%     
%     subplot(2,2,4)
%     plot(x,u4(:,i))
%     axis([0 L 0 1]);
%     ylabel('Concentration');
%     xlabel('Water,Wafer,Water,Brain');
%     title('P=3.67 (Carmustine)');
%     
    pause(0.01);
end


end

