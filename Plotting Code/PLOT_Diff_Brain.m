function [] = SURF_Diff_Brain( u1,p,t,tspan,g )
%PLOT_Diff_Brain - plots the solution of the brain diffusion problem

%CREATE SOLUTION MOVIES
fig = figure(1);
u = fig.Units;
fig.Units = 'normalized';
fig.Position = [0.3 0.3 0.7 0.7];

F1 = pdeInterpolant(p,t,u1);

xgrid = -1.5:0.01:1.5;
ygrid = -1:0.01:1;
[X,Y] = meshgrid(xgrid,ygrid);

uout1 = evaluate(F1,X,Y);

colormap(cool);
for i = 1:length(tspan)
    Z1 = reshape(uout1(:,i),size(X));
    mesh(xgrid,ygrid,Z1);
    axis([-1.5 1.5 -1 1]);
    hold on
    hold off
%     title('');
    shading interp;
    pause(0.01);
end

