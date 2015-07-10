PLOT_STORE = zeros(1,101);

for i = 1:20
    FREE_CONC = i/20;
    [ Min_Err,store,Store_Min_Err,x ] = Release_Profile_PB_ErrMin(Prop,1);
    PLOT_STORE = [PLOT_STORE;Store_Min_Err];
    Prop = FREE_CONC/(FREE_CONC+1);
    y(i) = Prop/(Prop + 1);
end

