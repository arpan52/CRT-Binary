function p= pwrcomp1(m,N,al1,al2,mu,beta,x1,design_l,al,beta0)


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
  u1=-0.5;
u2=0.5;
w1=-0.5;
w2=0.5;
  
  i11=(exp(u2)-exp(u1));
i12=(exp(u1+u2)+1);
i21=(u2-u1).*(exp(u1+u2));
i31=(i11.*i12)./i21;
k1=(i31+2);

j11=(exp(u2)-exp(u1)).*(exp(w2)-exp(w1));
j12=(exp(u1+u2+w1+w2)+1);
j21=(u2-u1).*(w2-w1).*(exp(u1+u2+w1+w2));
j31=(j11.*j12)./j21;
k2=(j31+2);

a111=2.*k1.*m.*(al1-1);
a112=sqrt(4.*k1.*k2.*(m.^2).*(al2-1).*(al1-1));
a211=a111-a112;
a311=a111+a112;

b111=k1.*(al1-1);
b112=k2.*(al2-1);
b113=2.*(m.^2).*(b111-b112);

x3(1)=a311./b113
x3(2)= (1/m)-x3(1)

 q5 = (m)*( x3(1)/((x3(1) - 1/N)*al1 + 1/N));
 q6 = (m)*(x3(2)/((x3(2) - 1/N)*al2 + 1/N));
 v3=(1/(gamma1*q5))+(1/(gamma2*q6))
 
 
 % variance for design using normal priors 
   %syms mu;
  %syms beta;
  v4 =vari(m,N,al1,al2,mu,beta)
 
 
 %variance for minimax design by H-algorithm
  q9 = (m)*( design_l(1)/((design_l(1) - 1/N)*al1 + 1/N));
  q10 = (m)*(design_l(m+1)/((design_l(m+1) - 1/N)*al2 + 1/N));
  v5=(1/(gamma1*q9))+(1/(gamma2*q10))
 
 
  
 %critical value and power calculation
  cv1 = beta0+(norminv(1-(al/2))*sqrt(v1));
cv2 = beta0+(norminv(1-(al/2))*sqrt(v2));
cv3 = beta0+(norminv(1-(al/2))*sqrt(v3));
cv4 = beta0+(norminv(1-(al/2))*sqrt(v4));
cv5 = beta0+(norminv(1-(al/2))*sqrt(v5));

zalpha=norminv(1-(al/2)) ;

p1 = 2*normpdf(((beta-beta0)/v1)-zalpha);
p2 = 2*normpdf(((beta-beta0)/v2)-zalpha);
p3 = 2*normpdf(((beta-beta0)/v3)-zalpha);
p4 = 2*normpdf(((beta-beta0)/v4)-zalpha);
p5 = 2*normpdf(((beta-beta0)/v5)-zalpha);

p = [p1 p2 p3 p4 p5]
 
end

function v4 =vari(m,N,al1,al2,mu,beta)
 
m=5;
N=100;
al1=0.2;
al2=0.3;
mu=0.5;
beta=1;
gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);

x4=  Normal_priors(m,N,al1,al2,mu,beta);

 q7 = (m)*( x4(1)/((x4(1) - 1/N)*al1 + 1/N));
 q8 = (m)*(x4(2)/((x4(2) - 1/N)*al2 + 1/N));
 v44=(1/(gamma1*q7))+(1/(gamma2*q8))
 v4=v44
end