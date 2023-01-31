clear all;
 mu=1 ;
beta=2;
al1=0.9;
al2=0.2;
N=50;
m=6;
beta0=0;
al=0.1;
%finding the locally optimal designs analytically

p1 = exp(mu)/(((1+exp(mu))^2)*(al1-1));
p2 = exp(mu+beta)/(((1+exp(mu+beta))^2)*(al2-1));
m1=m/2;

x(1)=(1/m1)*(1/(1+sqrt(p1/p2)));
x(m/2+1)= (1 - m1*x(1))/m1;
for i=1:m/2
    x(i)=x(1);
    x(i+m/2)=x(m/2+1);
end
x
 
%calculate power for this design
 
%pwr(m,N,al1,al2,x,mu,beta,al,beta0)


