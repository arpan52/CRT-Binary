al1=0.3;
al2=0.2;
N=50;
m=5;
Aeq=transpose(ones(10,1));
beq=1;
lb=zeros(10,1);
ub=ones(10,1);
A=[];
b=[];
x0=[0.1 0.2 0.1 0.3 0.2 0.1 0.1 0.2 0.1 0.5];


u1=0;
u2=2;
v1=0;
v2=1;

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



[x] = fmincon(@(x)fmin1(k1,k2,x,al1,al2,N,m),x0,A,b,Aeq,beq,lb,ub)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%from manual calculation result for first arm design by using lagrange
%multiplier
a111=2.*k1.*m.*(al1-1);
a112=sqrt(4.*k1.*k2.*(m.^2).*(al2-1).*(al1-1));
a211=a111-a112;
a311=a111+a112;

b111=k1.*(al1-1);
b112=k2.*(al2-1);
b113=2.*(m.^2).*(b111-b112);
z111=a211./b113
z11=a311./b113
z22= (1/m)-z11



%thus my second value of x is true