m1=15;
m2=10;
N=100;
al1=0.2;
al2=0.3;
mu=0.5;
beta=1;
m3=(m1+m2);
Aeq=transpose(ones(m3,1));
beq=1;
lb=zeros(m3,1);
ub=ones(m3,1);
A=[];
b=[];
x0=0.1.*ones(m3,1);
[x1] = fmincon(@(x)var_cluster_trt_diff_m(x,mu,beta,al1,al2,N,m1,m2),x0,A,b,Aeq,beq,lb,ub)

%calculating the power of the design

 mu=0.5;
beta=1;

gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
for i = 1:1:m1
    a1(i) = x1(i)./((x1(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x1(j)./((x1(j) - 1./N)*al2 + 1./N);
end
 q1=sum(a1);
 q2=sum(a2);
  v11=(1/(gamma1*q1))+(1/(gamma2*q2))
  zalpha=norminv(1-(al/2)) ;

p11 = 2*normpdf(((beta-beta0)/v11)-zalpha)