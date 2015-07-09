function [ store1,store2 ] = Release_Profile_PB_check( u,C_u,v,C_v,x1,x2,t )
%System Conc - Takes the various React_Diff_Solver1D's and outputs the
%total system concentration over time for three subdomains

%Set vectors to store each area point - THESE AREN'T NECESSARY IF YOU WANT
%TO OPTIMISE

test1 = zeros(1,size(x1,2)-1); %First subdomain
test2 = zeros(1,size(x2,2)-1); %Second subdomain
test3 = zeros(1,size(x2,2)-1); %Second subdomain
test4 = zeros(1,size(x2,2)-1); %Second subdomain

store1 = zeros(1,size(t,2));
store2 = zeros(1,size(t,2));

for j = 1:size(t,2)
    for i = 1:size(x1,2)-1
        test1(i) = 0.5*(x1(i+1)-x1(i))*(u(i+1,j)+u(i,j));
    end
    test_1 = sum(test1);

    for i = 1:size(x2,2)-1
        test2(i) = 0.5*(x2(i+1)-x2(i))*(u(i+1+length(x1),j)+u(i+length(x1),j));
    end
    test_2 = sum(test2);

    store1(j) = test_1 + test_2;

    for i = 1:size(x1,2)-1
        test3(i) = 0.5*(x1(i+1)-x1(i))*(v(i+1,j)+v(i,j));
    end
    test_3 = sum(test3);

    for i = 1:size(x2,2)-1
        test4(i) = 0.5*(x2(i+1)-x2(i))*(v(i+1+length(x1),j)+v(i+length(x1),j));
    end
    test_4 = sum(test4);

    store2(j) = test_3 + test_4;
end


%Plotting the percentage system concentration release over time
t_day = t/24;
plot(t_day,store1)
hold on
plot(t_day,store2)

%ETOPOSIDE
exp(1) = 0;
exp(2) = 33.222;
exp(3) = 50.486 + exp(2);
exp(4) = 12.346 + exp(3);
exp(5) = 3.946 + exp(4);

exp_x(1) = 0;
exp_x(2) = 4;
exp_x(3) = 24;
exp_x(4) = 72;
exp_x(5) = 240;
exp_x_day = exp_x/24;

plot(exp_x_day,exp)

set(gca,'fontsize',15)
xlabel('Day')
ylabel('Total Free Concentration')

hold off
end


