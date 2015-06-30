function [ test ] = System_Conc3( u,x1,x2,x3,t )
%System Conc - Takes the various React_Diff_Solver1D's and outputs the
%total system concentration over time for three subdomains

%Set vectors to store each area point - THESE AREN'T NECESSARY IF YOU WANT
%TO OPTIMISE

test1 = zeros(1,size(x1,2)-1); %First subdomain
test2 = zeros(1,size(x2,2)-1); %Second subdomain
test3 = zeros(1,size(x3,2)-1); %Third subdomain

test = zeros(1,size(t,2));


for j = 1:size(t,2)
    for i = 1:size(x1,2)-1
        test1(i) = 0.5*(x1(i+1)-x1(i))*(u(i+1,j)+u(i,j));
    end
    test_1 = sum(test1);

    for i = 1:size(x2,2)-1
        test2(i) = 0.5*(x2(i+1)-x2(i))*(u(i+1+length(x1),j)+u(i+length(x1),j));
    end
    test_2 = sum(test2);

    for i = 1:size(x3,2)-1
        test3(i) = 0.5*(x3(i+1)-x3(i))*(u(i+1+length(x1)+length(x2),j)+u(i+length(x1)+length(x2),j));
    end
    test_3 = sum(test3);
    
    test(j) = test_1 + test_2 + test_3;
end


%Plotting the system concentration over time
t_day = t/24;
plot(t_day,test)

set(gca,'fontsize',15)
xlabel('Day')
ylabel('Total Free Concentration')

end