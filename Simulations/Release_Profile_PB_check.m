function [ store1,store2 ] = Release_Profile_PB_check( u,C_u,v,C_v,x1,x2,t )
%System Conc - Takes the various React_Diff_Solver1D's and outputs the
%total system concentration over time for three subdomains

%Set vectors to store each area point - THESE AREN'T NECESSARY IF YOU WANT
%TO OPTIMISE

test1 = zeros(1,size(x1,2)-1); %Second subdomain

test3 = zeros(1,size(x2,2)-1); %Second subdomain


store1 = zeros(1,size(t,2));
store2 = zeros(1,size(t,2));

for j = 1:size(t,2)
    for i = 1:size(x2,2)-1
        test1(i) = 0.5*(x2(i+1)-x2(i))*(u(length(x1)+i+1,j)+u(length(x1)+i,j));
    end
    test_1 = sum(test1);
    
    store1(j) = test_1;

    for i = 1:size(x2,2)-1
        test3(i) = 0.5*(x2(i+1)-x2(i))*(v(length(x1)+i+1,j)+v(length(x1)+i,j));
    end
    test_3 = sum(test3);

    store2(j) = test_3;
end

store1 = 100*store1/C_u;
store2 = 100*store2/C_v;

%Plotting the percentage system concentration release over time


%ETOPOSIDE
exp(1) = 0;
exp(2) = 33.222;
exp(3) = 50.486;
exp(4) = 12.346;
exp(5) = 3.946;

exp_x(1) = 0;
exp_x(2) = 4;
exp_x(3) = 24;
exp_x(4) = 72;
exp_x(5) = 240;
exp_x_day = exp_x/24;

plot(exp_x_day,exp,'x')
hold on
t_day = t/24;
plot(t_day,store1)

plot(t_day,store2)


set(gca,'fontsize',15)
xlabel('Day')
ylabel('Total Percentage Release')

hold off
end


