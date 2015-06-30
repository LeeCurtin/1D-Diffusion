function [ test ] = Release_Profile_PWB( u,x1,x2,x3,t )
%Release_Profile - Takes the various React_Diff_Solver1D's and outputs the
%release profile for the paste over time

%Declare area vectors
test2 = zeros(1,size(x2,2)-1); %Second Subdomain
test3 = zeros(1,size(x3,2)-1); %Third Subdomain

test = zeros(1,size(t,2)); %Total Area

for j = 1:size(t,2) %Each Time Point
    for i = 1:size(x2,2)-1 %Each x-value in the second subdomain
        test2(i) = 0.5*(x2(i+1)-x2(i))*(u(i+1+length(x1),j)+u(i+length(x1),j)); 
    end
    test_2 = sum(test2);

    for i = 1:size(x3,2)-1 %Each x-value in the third subdomain
        test3(i) = 0.5*(x3(i+1)-x3(i))*(u(i+1+length(x1)+length(x2),j)+u(i+length(x1)+length(x2),j));
    end
    test_3 = sum(test3);
    
    test(j) = test_2 + test_3;
end

t_day = t/24;
test_prcnt = 100*test/2;
plot(t_day,test_prcnt)


set(gca,'fontsize',15)
xlabel('Day')
ylabel('Total Percentage Concentration Released')

end