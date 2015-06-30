function [] = Plot_React_Diff_Solver1D_REPORT( )
%Plot_React_Diff_Solver1D_Diff Plots the diffusion solution

% Plot numerical method
close all
figure(2)

%     plot(x1,u1(:,end))
%     hold on
%     plot(x2,u2(:,end))
%     plot(x3,u3(:,end))
%     plot(x4,u4(:,end))
%     hold off
%     set(gca,'fontsize',15)
%     str = sprintf('Time = %1.2f hours' ,t1(end));
%     title(str);
%     axis([0 x1(end) 0 1]);
%     ylabel('Concentration');
%     xlabel('Water,Wafer,Water,Brain');

[u1,x11,x12,x13,t1] = RDS_1D_Discont_Init_Srce_PWB(0.05,5,5,5,0.05,300,1.82);
x1 = [x11,x12,x13];

[u2,x11,x12,x13,t2] = RDS_1D_Discont_Init_Srce_PWB(0.05,5,5,5,0.05,300,1);
x2 = [x11,x12,x13];

[u3,x11,x12,x13,t3] = RDS_1D_Discont_Init_Srce_PWB(0.05,5,5,5,0.05,300,0.16);
x3 = [x11,x12,x13];

[u4,x11,x12,x13,t4] = RDS_1D_Discont_Init_Srce_PWB(0.05,5,5,5,0.05,300,4.62);
x4 = [x11,x12,x13];

n = 4; %Lazy parameter to change the time points

    subplot(2,3,1)
    h = area([0 5], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    hold on
    h = area([10 15], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    h = area([5 10], [0.3 0.3],'Facecolor',[1 1 1]);
    set(h,'EdgeColor','None');
    plot(x1,u3(:,1),'Color',[0.9290 0.6940 0.1250]);
    plot(x2,u2(:,1),'Color',[0.8500 0.3250 0.0980]);
    plot(x3,u1(:,1),'Color',[0 0.4470 0.7410]);
    plot(x4,u4(:,1),'Color',[0.4940 0.1840 0.5560]);
    hold off
    set(gca,'FontSize',15)%,'fontWeight','bold')
%     set( findobj(gca,'type','line'), 'LineWidth', 1.5);
%     str = sprintf('Time = %1.2f hours' ,t1(1));
%     title(str);
    axis([0 x1(end) 0 0.3]);
    ylabel('Concentration');
    xlabel('Paste - Fluid - Brain');
       
    subplot(2,3,2)
    h = area([0 5], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    hold on
    h = area([5 10], [0.3 0.3],'Facecolor',[1 1 1]);
    set(h,'EdgeColor','None');
    h = area([10 15], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    plot(x1,u3(:,1+(end-1)/n),'Color',[0.9290 0.6940 0.1250]);
    plot(x2,u2(:,1+(end-1)/n),'Color',[0.8500 0.3250 0.0980]);
    plot(x3,u1(:,1+(end-1)/n),'Color',[0 0.4470 0.7410]);
    plot(x4,u4(:,1+(end-1)/n),'Color',[0.4940 0.1840 0.5560]);
    hold off
    set(gca,'FontSize',15)%,'fontWeight','bold')
%     set( findobj(gca,'type','line'), 'LineWidth', 1.5);
%     str = sprintf('Time = %1.2f hours' ,t1(1+(end-1)/n));
%     title(str);
    axis([0 x1(end) 0 0.3 ]);
    set(gca,'ytick',[])
    xlabel('Paste - Fluid - Brain');
    
    subplot(2,3,3)
    h = area([0 5], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    hold on
    h = area([5 10], [0.3 0.3],'Facecolor',[1 1 1]);
    set(h,'EdgeColor','None');
    h = area([10 15], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    plot(x1,u3(:,1+2*(end-1)/n),'Color',[0.9290 0.6940 0.1250]);
    plot(x2,u2(:,1+2*(end-1)/n),'Color',[0.8500 0.3250 0.0980]);
    plot(x3,u1(:,1+2*(end-1)/n),'Color',[0 0.4470 0.7410]);
    plot(x4,u4(:,1+2*(end-1)/n),'Color',[0.4940 0.1840 0.5560]);
    hold off
    set(gca,'FontSize',15)%,'fontWeight','bold')
%     set( findobj(gca,'type','line'), 'LineWidth', 1.5);
%     str = sprintf('Time = %1.2f hours' ,t1(1+2*(end-1)/n));
%     title(str);
    axis([0 x1(end) 0 0.3]);
    set(gca,'ytick',[])
%     ylabel('Concentration');
    xlabel('Paste - Fluid - Brain');
    
    subplot(2,3,4)
    h = area([0 5], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]); 
    set(h,'EdgeColor','None');
    hold on
    h = area([5 10], [0.3 0.3],'Facecolor',[1 1 1]);
    set(h,'EdgeColor','None');
    h = area([10 15], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    plot(x1,u3(:,1+3*(end-1)/n),'Color',[0.9290 0.6940 0.1250]);
    plot(x2,u2(:,1+3*(end-1)/n),'Color',[0.8500 0.3250 0.0980]);
    plot(x3,u1(:,1+3*(end-1)/n),'Color',[0 0.4470 0.7410]);
    plot(x4,u4(:,1+3*(end-1)/n),'Color',[0.4940 0.1840 0.5560]);
    hold off
    set(gca,'FontSize',15)%,'fontWeight','bold')
%     set( findobj(gca,'type','line'), 'LineWidth', 1.5);
%     str = sprintf('Time = %1.2f hours' ,t1(1+3*(end-1)/n));
%     title(str);
    axis([0 x1(end) 0 0.3]);
%     set(gca,'ytick',[])
    ylabel('Concentration');
    xlabel('Paste - Fluid - Brain');

    subplot(2,3,5)
    h = area([0 5], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);   
    set(h,'EdgeColor','None');
    hold on
    h = area([5 10], [0.3 0.3],'Facecolor',[1 1 1]);
    set(h,'EdgeColor','None');
    h = area([10 15], [0.3 0.3],'Facecolor',[0.95 0.95 0.95]);
    set(h,'EdgeColor','None');
    h3 = plot(x1,u3(:,end),'Color',[0.9290 0.6940 0.1250]);
    h4 = plot(x2,u2(:,end),'Color',[0.8500 0.3250 0.0980]);
    h5 = plot(x3,u1(:,end),'Color',[0 0.4470 0.7410]);
    h6 = plot(x4,u4(:,end),'Color',[0.4940 0.1840 0.5560]);
    hold off
    set(gca,'FontSize',15)%,'fontWeight','bold')
%     set( findobj(gca,'type','line'), 'LineWidth', 1.5);
%     str = sprintf('Time = %1.2f hours' ,t1(1+3*(end-1)/n));
%     title(str);
    axis([0 x1(end) 0 0.3]);
    set(gca,'ytick',[])
    legend([h3 h4 h5 h6],{'P = 0.16 - Methotrexate','P = 1.00','P = 1.82 - Etoposide','P = 4.62 - Carmustine'},'FontSize',12);
%     ylabel('Concentration');
    xlabel('Paste - Fluid - Brain');

% FigureSize( 42, 6 , 'centimeters' )
FigureSize( 30, 15 , 'centimeters' )

end
