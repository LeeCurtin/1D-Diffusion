function [ ] = Plot_Gap( gap,P1,P2,P3,P4 )
%Plot_Gap - A quick function to plot the evolution of the concentration at
%one domain point over time with different gap lengths and P values.
figure(1)

for i = size(P1,2)% 1:size(P1,2)
plot(gap,P3(:,i),'Color',[0.9290 0.6940 0.1250]);
hold on
plot(gap,P2(:,i),'Color',[0.8500 0.3250 0.0980]);
plot(gap,P1(:,i),'Color',[0 0.4470 0.7410]);
plot(gap,P4(:,i),'Color',[0.4940 0.1840 0.5560]);
legend('P = 0.16 - Methotrexate','P = 1.00 - No Preference','P = 1.82 - Etoposide','P = 4.62 - Carmustine');


axis([0,gap(end),0,0.3])
set(gca,'fontsize',20)
ylabel('Concentration')
xlabel('Gap Length (mm)')
hold off
pause(0.01)
end
hold off

end

