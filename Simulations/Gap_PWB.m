function [l2,store1,store2,store3,store4 ] = Gap_PWB(h,l1,l3,tau,tend )
%Function to produce nice graphs about the differing CSF gap sizes

n = 10;
m = 5;

[u,x1,x2,t] = RDS_1D_Discont_Init_Srce_PB(h/5,l1,l3,tau,tend,1.82);
store = zeros(length(x2),length(t));
for i = 1:length(x2)
store(i,:) = u(length(x1)+i,:);
end
store1(1,:) = sum(store)/length(x2);
clear store

[u,x1,x2] = RDS_1D_Discont_Init_Srce_PB(h/5,l1,l3,tau,tend,1);
for i = 1:length(x2)
store(i,:) = u(length(x1)+i,:);
end
store2(1,:) = sum(store)/length(x2);
clear store

[u,x1,x2] = RDS_1D_Discont_Init_Srce_PB(h/5,l1,l3,tau,tend,0.16);
for i = 1:length(x2)
store(i,:) = u(length(x1)+i,:);
end
store3(1,:) = sum(store)/length(x2);
clear store

[u,x1,x2] = RDS_1D_Discont_Init_Srce_PB(h/5,l1,l3,tau,tend,4.62);
for i = 1:length(x2)
store(i,:) = u(length(x1)+i,:);
end
store4(1,:) = sum(store)/length(x2);
clear store


for i = 1:m
[u,x1,x2,x3,t] = RDS_1D_Discont_Init_Srce_PWB(h,l1,i/n,l3,tau,tend,1.82);
store = zeros(length(x3),length(t));
for j = 1:length(x3)
store(j,:) = u(length(x1)+length(x2)+j,:);
end
store1(i+1,:) = sum(store)/length(x3);
clear store

[u,x1,x2,x3] = RDS_1D_Discont_Init_Srce_PWB(h,l1,i/n,l3,tau,tend,1);
for j = 1:length(x3)
store(j,:) = u(length(x1)+length(x2)+j,:);
end
store2(i+1,:) = sum(store)/length(x3);
clear store

[u,x1,x2,x3] = RDS_1D_Discont_Init_Srce_PWB(h,l1,i/n,l3,tau,tend,0.16);
for j = 1:length(x3)
store(j,:) = u(length(x1)+length(x2)+j,:);
end
store3(i+1,:) = sum(store)/length(x3);
clear store

[u,x1,x2,x3] = RDS_1D_Discont_Init_Srce_PWB(h,l1,i/n,l3,tau,tend,4.62);
for j = 1:length(x3)
store(j,:) = u(length(x1)+length(x2)+j,:);
end
store4(i+1,:) = sum(store)/length(x3);
clear store
end

l2 = 0:1/n:m/n;

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

