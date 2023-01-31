function ret_val = psi1(design,theta)
mu=theta(1);
beta=theta(2);
al1=0.9;
al2=0.2;
N=50;
m=6;
x1=design(1);
x2=design((m/2)+1);

% beta0=1;
% al=1;
%finding the locally optimal designs analytically

gamma1 = exp(mu)/((1+exp(mu))^2);
gamma2 = exp(mu+beta)/((1+exp(mu+beta))^2);
m1=m/2;
%psi function
psi1= (1/(gamma1*((m1*x1)/((x1-(1/N)*al1)+(1/N)))))+(1/(gamma2*((m1*x2)/((x2-(1/N)*al1)+(1/N)))));
ret_val=psi1;
end