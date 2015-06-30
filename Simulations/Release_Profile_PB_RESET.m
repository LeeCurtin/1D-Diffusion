function [ test ] = Release_Profile_PB_RESET( v,w,x2 )
%Release_Profile - Takes the various React_Diff_Solver1D's and outputs the
%release profile for the paste over time

%Declare area vectors
test2 = zeros(1,size(x2,2)-1); %Second Subdomain

test = zeros(1,size(v,2)+1); %Total Area

for j = 1:size(v,2) %Each Time Point
    for i = 1:size(x2,2)-1 %Each x-value in the second subdomain
        test2(i) = 0.5*(x2(i+1)-x2(i))*(v(i+1,j)+v(i,j)); 
    end
    test_2 = sum(test2);

    test(j+1) = test_2 + test(j);
end

plot(w,test)


set(gca,'fontsize',15)
xlabel('Time (hours)')
ylabel('Total Percentage Concentration Released')

end