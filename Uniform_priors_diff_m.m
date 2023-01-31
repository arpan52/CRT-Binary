%number of subjects and clusters in each arm
N=100;
m1=15;
m2=10;
%lower and upper limit of uniform priors for \mu and \beta
u1=0;
u2=2;
v1=0;
v2=1;

%correlation of arms
al1=0.3;
al2=0.2;

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



[x] = fmincon(@(x)fmin1diff_m(k1,k2,x,al1,al2,N,m1,m2),x0,A,b,Aeq,beq,lb,ub)

%calculating the power of the design

 mu=0.5;
beta=1;

gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
for i = 1:1:m1
    a1(i) = x(i)./((x(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x(j)./((x(j) - 1./N)*al2 + 1./N);
end
 q1=sum(a1);
 q2=sum(a2);
  v11=(1/(gamma1*q1))+(1/(gamma2*q2))
  zalpha=norminv(1-(al/2)) ;

p11 = 2*normpdf(((beta-beta0)/v11)-zalpha)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%from manual calculation result for first arm design by using lagrange
%multiplier
% a111=2.*k1.*m.*(al1-1);
% a112=sqrt(4.*k1.*k2.*(m.^2).*(al2-1).*(al1-1));
% a211=a111-a112;
% a311=a111+a112;
% 
% b111=k1.*(al1-1);
% b112=k2.*(al2-1);
% b113=2.*(m.^2).*(b111-b112);
% z111=a211./b113
% z11=a311./b113
% z22= (1/m)-z11


