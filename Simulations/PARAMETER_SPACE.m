PLOT_STORE = zeros(1,100);

for i = 1:20
    Prop = i/20;
    [ Min_Err,store,Store_Min_Err,x ] = Release_Profile_PB_ErrMin(Prop,1);
    PLOT_STORE = [PLOT_STORE;Store_Min_Err];
    y(i) = Prop/(Prop + 1);
end

