function [ Min_Err,store,Store_Min_Err ] = Release_Profile_PB_ErrMin()
%Minimising the error between simulated release profiles and experimental
%ones assuming knowledge of diffusion coefficients but not release rates
%Error found as the sum of differences in released percentage concentration

Min_Err = 10000; %Minimum stored error
NUM_K = 30; %Number of k-values checked

Store_Min_Err = zeros(1,NUM_K);

for i = 1:NUM_K
    k = i/10;
    [~,~,x2,~,v,w] = RDS_1D_Discont_Init_Srce_PB_RESET(0.05,5,5,0.01,240,k);
    
    [ test ] = Release_Profile_PB_RESET( v,w,x2 );
    test
    Err1 = abs(56.465 - test(2));
    Err2 = abs(30.843 - (test(3)-test(2)));
    Err3 = abs(6.838 - (test(4)-test(3)));
    Err4 = abs(1.862 - (test(5)-test(4)));
    
    Min_Err_temp = Err1+Err2+Err3+Err4;
    Store_Min_Err(i) = Min_Err_temp;
    x(i) = i/10;
    if Min_Err_temp < Min_Err
        Min_Err = Min_Err_temp;
        store = k;
    end
end
plot(x,Store_Min_Err)

end

