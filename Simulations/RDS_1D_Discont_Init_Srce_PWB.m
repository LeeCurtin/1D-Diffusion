function [u,x1,x2,x3,t,L] = RDS_1D_Discont_Init_Srce_PWB(h,l,l1,l2,tau,tend,p)
% A function to solve the following reaction diffusion equation:
%C_t = D(x)C_xx + f(x,t) where f(x,t) is seperable in x and t and D is
%constant on different regions of the domain.
%l, l2 and l3 are the lengths of the three materials, h and tau are
%domain and time step size respectively, with tend being the end time of
%the simulation. This allows for discontinuities that model the
%hydrophobicity of the diffusing drug with octanol-water partition coefficient, p
% - the steady states should not be uniform when these discontinuities occur.

tic %Starts implementation time

%Create Mesh

x0 = 0;
L = l + l1 + l2; %Length of domain
x1 = x0:h:l;
x2 = l:h:l+l1;
x3 = l+l1:h:l+l1+l2;
x = [x1,x2,x3];

    
% Mesh that is refined around the interfaces between all materials

% x0 = 0;
% L = l1 + l2; %Length of domain
% r = 4; %refinement factor
% x11 = x0              h:      3*l1/4;
% x12 = 3*l1/4+h:       h/r:    l1;
% x21 = l1:             h/r:    l1+l2/4;
% x22 = l1+l2/4+h:      h:      l1+3*l2/4;
% x23 = l1+3*l2/4+h:    h/r:    l1+l2;
% x31 = l1+l2:          h/r:    l1+l2+l3/4;
% x32 = l1+l2+l3/4+h:   h:      L;
% 
% x1 = [x11,x12];
% x2 = [x21,x22,x23];
% x3 = [x31,x32];
% x = [x1,x2,x3];
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


%Source term (does not encode where the source term occurs)
g=zeros(1,length(t));
for i = 1:length(t)
    g(i) = k*C_0b*exp(-k*t(i))/l;
end


%Boundary Conditions (First two entries are values, last two turn off or
%on)

Neu = [0,0,1,1]; %Neumann Boundary Conditions
Dir = [0,0,0,0]; % Dirichlet Boundary Conditions

    
function [D] = Diffusivity1(x1) 
D1 = 3600*67.e-6;   %Diffusion coefficient (mm^2/h) in wafer for Carmustine

for i = 1:length(x1)
        D = D1;
end

end

function [D] = Diffusivity2(x2) 
D2 = 3600*50.e-5;  %" " " water for Carmustine

for i = 1:length(x2)
        D = D2;
end

end

function [D] = Diffusivity3(x3) 
D3 = 3600*25.e-5; %" " " normal brain tissue for Carmustine

for i = 1:length(x3)
        D = D3;
end

end

function [f] = Sourcef_2(x) %Setting where the source term occurs
 f = 0;   

for m = 1:length(x)
    if (x(m)>=0) && (x(m)<=l)
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
A3 = GaussStiffnessAssembler1D_Diff(x3,Dir,w,@Diffusivity3,y);
A = StiffnessAssemblerDiscont3(A1,A2,A3,1,p);

b1 = GaussLoadAssembler1D(x1,@Sourcef_2,Neu,Dir,y,w);
b2 = GaussLoadAssembler1D(x2,@Sourcef_2,Neu,Dir,y,w);
b3 = GaussLoadAssembler1D(x3,@Sourcef_2,Neu,Dir,y,w);
b = LoadAssemblerDiscont3( b1,b2,b3 );


M1 = GaussMassAssembler1D(x1,Dir,y,w);
M2 = GaussMassAssembler1D(x2,Dir,y,w);
M3 = GaussMassAssembler1D(x3,Dir,y,w);
M = StiffnessAssemblerDiscont3(M1,M2,M3,1,p);
% M = blkdiag(M1,M2,M3);


%Solve System at each time point

%Initial Condition - setting the initial free proportion in the paste
u = zeros(length(x),length(t));
for i = 1:length(x1)
        u(i,1) = C_0f/l;
end

%Solving the problem at each time point

theta = 1; %theta = 0 is forward Euler, theta = 1 is backward

LHS = M/tau + theta*A;
for n = 1:length(t)-1
    RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b;
    u(:,n+1) = LHS\RHS;
end

% %Source Term
% u = zeros(length(x),length(t));
% 
% theta = 1;%0.6565;
% LHS = M/tau + theta*A;
% for n = 1:length(t)-1
%     RHS = (M/tau-(1-theta)*A)*u(:,n) + ((1-theta)*g(n)+theta*g(n+1))*b/l1;
%     u(:,n+1) = LHS\RHS;
%     100*n/(length(t)-1);
% end

toc %Ends implementation time


end
