function p= pwr(m,N,al1,al2,x,mu,beta,al,beta0)

%calculate the variance 
gamma1= exp(mu)/((1+exp(mu))^2);
gamma2= exp(mu+beta)/((1+exp(mu+beta))^2);
 q1 = (m/2)*( x(1)/((x(1) - 1/N)*al1 + 1/N));
 q2 = (m/2)*(x(m/2+1)/((x(m/2+1) - 1/N)*al2 + 1/N));
 v1=(1/(gamma1*q1))+(1/(gamma2*q2))
 
 %variance of balanced design
  q3 = (m/2)*( (1/m)/(((1/m) - 1/N)*al1 + 1/N));
 q4 = (m/2)*((1/m)/(((1/m) - 1/N)*al2 + 1/N));
 v2=(1/(gamma1*q3))+(1/(gamma2*q4))
 
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