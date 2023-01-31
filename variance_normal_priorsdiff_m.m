 m=15 ; %cluster size in each arm
N=100;  %total participants
 al1=0.2;
 al2=0.3;
 

beta0=0;
al=0.05
 
 
  syms mu;
  syms beta;
x4=  Normal_priors(m,N,al1,al2,mu,beta)
%x4=transpose(x)
 mu=0.5;
beta=1;

gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
  q1 = (m)*( x4(1)/((x4(1) - 1/N)*al1 + 1/N));
  q2 = (m)*(x4(m+1)/((x4(m+1) - 1/N)*al2 + 1/N));
  v11=(1/(gamma1*q1))+(1/(gamma2*q2))
  zalpha=norminv(1-(al/2)) ;

p11 = 2*normpdf(((beta-beta0)/v11)-zalpha)