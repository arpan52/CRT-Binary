
function [x4] = Normal_priors_diff_m(m1,m2,N,al1,al2,mu,beta)
a11=0; %mean of mu
b12=1; %variance of mu
c21=0; %mean of beta
d22=1 ;%variance of beta

% m=5 ; %cluster size in each arm
% N=50;  %total participants
% al1=0.3;
% al2=0.2;
m3=(m1+m2);
Aeq=transpose(ones(m3,1));
beq=1;
lb=zeros(m3,1);
ub=ones(m3,1);
A=[];
b=[];
x0=(0.1).*ones(m3,1);
%x0=[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1];

%calculating integration
  syms mu
  syms beta
 z1=double(int(int(@(mu,beta)part1(a11,b12,c21,d22,mu,beta),mu,-inf,inf),beta,-inf,inf))
 z2=double(int(int(@(mu,beta)part2(a11,b12,c21,d22,mu,beta),mu,-inf,inf),beta,-inf,inf))



%calulating constant
k0=double((1./(2.*pi)).*(1./(b12.*d22)))
%applying fmincon

x4=fmincon(@(x)fmin2diff_m(k0,z1,z2,x,N,m1,m2,al1,al2),x0,A,b,Aeq,beq,lb,ub)



for i = 1:1:m1
    a1(i) = x4(i)./((x4(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x4(j)./((x4(j) - 1./N)*al2 + 1./N);
end
v4=k0.*(z1/(sum(a1)))+(z2/(sum(a2)))
x4

function y = fmin2diff_m(k0,z1,z2,x4,N,m1,m2,al1,al2)
 a1 = [];
 a2 = [];
for i = 1:1:m1
    a1(i) = x4(i)./((x4(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x4(j)./((x4(j) - 1./N)*al2 + 1./N);
end
y=k0.*(z1/(sum(a1)))+(z2/(sum(a2)));
end


end
