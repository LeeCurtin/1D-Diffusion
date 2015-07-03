function [ test ] = Release_Profile_PB( u,x1,x2,t )
%Release_Profile - Takes the various React_Diff_Solver1D's and outputs the
%release profile for the paste over time

%Declare area vectors
test2 = zeros(1,size(x2,2)-1); %Second Subdomain

test = zeros(1,size(t,2)); %Total Area

for j = 1:size(t,2) %Each Time Point
    for i = 1:size(x2,2)-1 %Each x-value in the second subdomain
        test2(i) = 0.5*(x2(i+1)-x2(i))*(u(i+1+length(x1),j)+u(i+length(x1),j)); 
    end
    test_2 = sum(test2);
    
    test(1,j) = test_2;

end

t_day = t/24;
test_prcnt = 100*test/2;
plot(t_day,test_prcnt)


set(gca,'fontsize',15)
xlabel('Day')
ylabel('Total Percentage Concentration Released')

end

