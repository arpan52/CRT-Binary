 mu=0.1;
beta=0.3;
al1=0.3;
al2=0.2;
N=50;
m=6;
Aeq=transpose(ones(6,1));
beq=1;
lb=zeros(6,1);
ub=ones(6,1);
A=[];
b=[];
x0=[0.1 0.2 0.1 0.3 0.2 0.1];
[x1, val] = fmincon(@(x)var_cluster_trt(x,mu,beta,al1,al2,N,m),x0,A,b,Aeq,beq,lb,ub)

