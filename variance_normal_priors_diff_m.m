 m1=12;
 m2=15; %cluster size in each arm
N=200;  %total participants
 al1=0.1;
 al2=0.2;
 

beta0=0;
al=0.05
 
 
  syms mu;
  syms beta;
x4=  Normal_priors_diff_m(m1,m2,N,al1,al2,mu,beta)
%x4=transpose(x)

%calculating the Power of the design
 mu=0.5;
beta=1;

gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
for i = 1:1:m1
    a1(i) = x4(i)./((x4(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x4(j)./((x4(j) - 1./N)*al2 + 1./N);
end
 q1=sum(a1);
 q2=sum(a2);
  v11=(1/(gamma1*q1))+(1/(gamma2*q2))
  zalpha=norminv(1-(al/2)) ;

p11 = 2*normpdf(((beta-beta0)/v11)-zalpha)