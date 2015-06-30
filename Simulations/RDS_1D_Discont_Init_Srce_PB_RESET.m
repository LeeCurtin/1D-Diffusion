function [u,x1,x2,t,v] = RDS_1D_Discont_Init_Srce_PB_RESET(h,l1,l2,tau,tend,p)
% A function to solve the following reaction diffusion equation:
%C_t = D(x)C_xx + f(x,t) where f(x,t) is seperable in x and t and D is
%constant on different regions of the domain.
%l, l2 and l3 are the lengths of the three materials, h and tau are
%domain and time step size respectively, with tend being the end time of
%the simulation. This allows for discontinuities that model the
%hydrophobicity of the diffusing drug - the steady states should not be
%uniform when these discontinuities occur.

tic %Starts implementation time

%Create Mesh

x0 = 0;
L = l1 + l2; %Length of domain
x1 = x0:h:l1;
x2 = l1:h:L;
x = [x1,x2];

    
% Mesh that is refined around the interfaces between all materials

% x0 = 0;
% L = l1 + l2; %Length of domain
% r = 4; %refinement factor
% x11 = x0              h:      3*l1/4;
% x12 = 3*l1/4+h:       h/r:    l1;
% x21 = l1:             h/r:    l1+l2/4;
% x22 = l1+l2/4+h:      h:      L;

% x1 = [x11,x12];
% x2 = [x21,x22,x23];

% x = [x1,x2];
% end


%Set time interval
t0 = 0;
t = t0:tau:tend;

%Properties
% p = 0.5; %Octanol-Water Coefficient
k = 0.0625; %Rate of splitting of drug and paste
C_0b = 1; %Initial 'bound' drug
C_0f = 1; %Initial 'free' drug
C_0 = C_0b + C_0f; %Total drug in system


%Source term
g=zeros(1,length(t));
for i = 1:length(t)
    g(i) = k*C_0b*exp(-k*t(i))/l1;
end

%Boundary Conditions
Neu = [0,0,1,1]; %Neumann Boundary Conditions
Dir = [0,0,0,0]; % Dirichlet Boundary Conditions

    
function [D] = Diffusivity1(x1) 
D1 = 3600*50.e-6;   %Diffusion coefficient (mm^2/h) in wafer for Carmustine
for i = 1:length(x1)
        D = D1;
end

end

function [D] = Diffusivity2(x2)
D3 = 3600*25.e-5; %" " " normal brain tissue for Carmustine

for i = 1:length(x2)
        D = D3;
end

end

function [f] = Sourcef_2(x)
 f = 0;   

for m = 1:length(x)
    if (x(m)>=0) && (x(m)<=l1)
    f = 1;
    else f = 0;
    end
end

end

%Find roots of Legendre polynomial
N=2;
[y,w] = GaussIntegration(N);

%Compute Stiffness Matrix and Load Vector

A1 = GaussStiffnessAssembler1D_Diff(x1,Dir,w,@Diffusivity1,y);
A2 = GaussStiffnessAssembler1D_Diff(x2,Dir,w,@Diffusivity2,y);
A = StiffnessAssemblerDiscont2(A1,A2,1,p); %MAKE A NEW FUNCTION FOR TWO SUBDOMAINS

b1 = GaussLoadAssembler1D(x1,@Sourcef_2,Neu,Dir,y,w);
b2 = GaussLoadAssembler1D(x2,@Sourcef_2,Neu,Dir,y,w);
b = LoadAssemblerDiscont2( b1,b2 ); %MAKE A NEW FUNCTION FOR TWO SUBDOMAINS


M1 = GaussMassAssembler1D(x1,Dir,y,w);
M2 = GaussMassAssembler1D(x2,Dir,y,w);
M = blkdiag(M1,M2);

%Solve System at each time point

%Initial Condition
TP = 4; %Number of Time Points
Time1 = t0:             tau:    tend/TP;
Time2 = tend/TP +   tau:tau:    2*tend/TP;
Time3 = 2*tend/TP + tau:tau:    3*tend/TP;
Time4 = 3*tend/TP + tau:tau:    tend;

u = zeros(length(x),length(t)+TP-1);
for i = 1:length(x1)
        u(i,1) = C_0f/l1;
end

v = zeros(length(x),length(TP)); %Stores u values at time points before reset

theta = 1;
LHS = M/tau + theta*A;

for n = 1:length(Time1)-1
    RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b;
    u(:,n+1) = LHS\RHS;
end

v(:,1) = u(:,length(Time1));

for i = 1:length(x2)
u(length(x1) + i,length(Time1)) = 0;
end

for n = length(Time1):length(Time1) + length(Time2) - 1
    RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b;
    u(:,n+1) = LHS\RHS;
end

v(:,2) = u(:,length(Time2));

for i = 1:length(x2)
u(length(x1) + i,length(Time1)+length(Time2)) = 0;
end

for n = length(Time1)+length(Time2):length(Time1)+length(Time2)+ length(Time3) - 1
    RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b;
    u(:,n+1) = LHS\RHS;
end

v(:,3) = u(:,length(Time3));

for i = 1:length(x2)
u(length(x1) + i,length(Time1)+length(Time2)+length(Time3)) = 0;
end

for n = length(Time1)+length(Time2)+length(Time3):length(Time1)+length(Time2)+length(Time3)+length(Time4)-1
    RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b;
    u(:,n+1) = LHS\RHS;
end

v(:,4) = u(:,end);

toc %Ends implementation time


end


