function p= pwrcomp(m,N,al1,al2,x1,v4,z1,z2,k0,mu,beta,al,beta0)

% variance for locally optimal design
gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
 q1 = (m)*( x1(1)/((x1(1) - 1/N)*al1 + 1/N));
 q2 = (m)*(x1(m+1)/((x1(m+1) - 1/N)*al2 + 1/N));
 v1=(1/(gamma1*q1))+(1/(gamma2*q2))
 
 %variance of balanced design
  q3 = (m)*( (1/(2.*m))/(((1/(2.*m)) - 1/N)*al1 + 1/N));
 q4 = (m)*((1/(2.*m))/(((1/(2.*m)) - 1/N)*al2 + 1/N));
 v2=(1/(gamma1*q3))+(1/(gamma2*q4))
 
 %variance for design using uniform priors
 
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

a111=2.*k1.*m.*(al1-1);
a112=sqrt(4.*k1.*k2.*(m.^2).*(al2-1).*(al1-1));
a211=a111-a112;
a311=a111+a112;

b111=k1.*(al1-1);
b112=k2.*(al2-1);
b113=2.*(m.^2).*(b111-b112);

z11=a311./b113
z22= (1/m)-z11

for i = 1:m
    a1(i) = z11/((z11 - 1/N)*al1 + 1/N);
    a2(i) = z22/((z22 - 1/N)*al2 + 1/N);
end

 
v3 = (k1/(sum(a1))) +( k2/(sum(a2)))
 
 % variance for design using normal priors
 


 v4=Normal_priors(m,N,al1,al2,mu,beta);

 
 
 %calculate the critical value

cv = beta0+(norminv(1-(al/2))*sqrt(v1));

%calculate the power
% I = @(t) exp(-((x).^2)/(2)) / (sqrt(2*pi));
% power = int(I,[cv inf])

zalpha=norminv(1-(al/2)) ;

p1 = 2*normpdf(((beta-beta0)/v1)-zalpha);
p2 = 2*normpdf(((beta-beta0)/v2)-zalpha);
%  p3 = (2*normpdf(((beta0-1)/v2)+zalpha))
p = [p1 p2]
end