m=15;
N=100;
al1=0.2;
al2=0.3;
mu=0.5;
beta=1;
m2=2*m;
Aeq=transpose(ones(m2,1));
beq=1;
lb=zeros(m2,1);
ub=ones(m2,1);
A=[];
b=[];
x0=0.1.*ones(m2,1);
[x1] = fmincon(@(x)var_cluster_trt(x,mu,beta,al1,al2,N,m),x0,A,b,Aeq,beq,lb,ub)

