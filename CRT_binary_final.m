 m1=12;
 m2=15; %cluster size in each arm
N=200;  %total participants
 al1=0.1;
 al2=0.2;
 


% For Normal priors with different m
a11=0; %mean of mu
b12=1; %variance of mu
c21=0; %mean of beta
d22=1 ;%variance of beta
 syms mu;
  syms beta;

[x_normal] =  Normal_priors_diff_m(m1,m2,N,al1,al2,mu,beta,a11,b12,c21,d22);
%calculating the variance of the design
 mu=0.5;
beta=1;

gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
for i = 1:1:m1
    a1(i) = x_normal(i)./((x_normal(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x_normal(j)./((x_normal(j) - 1./N)*al2 + 1./N);
end
 q1=sum(a1);
 q2=sum(a2);
 x4
   v_normal=(1/(gamma1*q1))+(1/(gamma2*q2))
   
   
   
   
   
   % for Uniform priors
   
   %lower and upper limit of uniform priors for \mu and \beta
u1=0;
u2=2;
v1=0;
v2=1;

Aeq=transpose(ones((m1+m2),1));
beq=1;
lb=zeros((m1+m2),1);
ub=ones((m1+m2),1);
A=[];
b=[];
x0=(0.1).*ones((m1+m2),1);




i11=(exp(u2)-exp(u1));
i12=(exp(u1+u2)+1);
i21=(u2-u1).*(exp(u1+u2));
i31=(i11.*i12)./i21;
k1=(i31+2);

j11=(exp(u2)-exp(u1)).*(exp(v2)-exp(v1));
j12=(exp(u1+u2+v1+v2)+1);
j21=(u2-u1).*(v2-v1).*(exp(u1+u2+v1+v2));
j31=(j11.*j12)./j21;
k2=(j31+2);



[x_uniform] = fmincon(@(x)fmin1diff_m(k1,k2,x,al1,al2,N,m1,m2),x0,A,b,Aeq,beq,lb,ub);
for i = 1:1:m1
    b1(i) = x_uniform(i)./((x_uniform(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    b2(j) = x_uniform(j)./((x_uniform(j) - 1./N)*al2 + 1./N);
end
 q1=sum(b1);
 q2=sum(b2);
 x_uniform
   v_normal=(1/(gamma1*q1))+(1/(gamma2*q2))
   
