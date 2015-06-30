function [l1,storeP05,storeP1,storeP15,storeP367 ] = Gap(h,l,l1,l3,tau,tend )
%Function to produce nice graphs about the differing CSF gap sizes

n = 20;
m = 100;

for i = 0:m
[u] = RDS_1D_Discont_Initial_Source(h,l,l1,i/n,l3,tau,tend,0.5);
storeP05(i+1,:) = u(end,:);
[u] = RDS_1D_Discont_Initial_Source(h,l,l1,i/n,l3,tau,tend,1);
storeP1(i+1,:) = u(end,:);
[u] = RDS_1D_Discont_Initial_Source(h,l,l1,i/n,l3,tau,tend,1.5);
storeP15(i+1,:) = u(end,:);
[u] = RDS_1D_Discont_Initial_Source(h,l,l1,i/n,l3,tau,tend,3.67);
storeP367(i+1,:)= u(end,:);
end

l1 = 0:1/n:m/n;

% figure(3)
% plot(l1,storeP05(:,end))
% hold on
% plot(l1,storeP1(:,end))
% plot(l1,storeP15(:,end))
% plot(l1,storeP367(:,end))
% ylabel('Concentration')
% xlabel('Gap Length (mm)')
% legend('P = 0.50','P = 1.00','P = 1.50','P = 3.67')
% hold off
end

