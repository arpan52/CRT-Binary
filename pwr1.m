function [pr1,pr2]= pwr1(m,N,al1,al2,x,mu,beta,al,beta0)

i=1
for beta=[1:0.2:5]
     if(i<=21)
    %calculate the variance 
gamma1(i)= exp(mu)/((1+exp(mu))^2);
gamma2(i)= exp(mu+beta)/((1+exp(mu+beta))^2);
 q1(i) = (m/2)*( x(i,1)/((x(i,1) - 1/N)*al1 + 1/N));
 q2(i) = (m/2)*(x(i,m/2+1)/((x(i,m/2+1) - 1/N)*al2 + 1/N));
 v1(i)=(1/(gamma1(i)*q1(i)))+(1/(gamma2(i)*q2(i)))
 
 %variance of balanced design
  q3 = (m/2)*( (1/m)/(((1/m) - 1/N)*al1 + 1/N));
 q4 = (m/2)*((1/m)/(((1/m) - 1/N)*al2 + 1/N));
 v2(i)=(1/(gamma1(i)*q3))+(1/(gamma2(i)*q4))
 
  %calculate the critical value

cv(i) = beta0+(norminv(1-(al/2))*sqrt(v1(i)));
 
%calculate the power
% I = @(t) exp(-((x).^2)/(2)) / (sqrt(2*pi));
% power = int(I,[cv inf])

zalpha=norminv(1-(al/2)) ;
%power of our design
pr1(i) = 2*normpdf(((beta-beta0)/v1(i))-zalpha);

%power of balanced design
pr2(i) = 2*normpdf(((beta-beta0)/v2(i))-zalpha);
     end
     i=i+1
%  p3 = (2*normpdf(((beta0-1)/v2)+zalpha))

end
pr1
pr2
end
 


