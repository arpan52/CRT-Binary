function p = p(x,mu,beta,al,beta0,v)
%calculate the critical value

cv = beta0+(norminv(1-(al/2))*sqrt(v));

%calculate the power
% I = @(t) exp(-((x).^2)/(2)) / (sqrt(2*pi));
% power = int(I,[cv inf]) 
zalpha=norminv(1-(al/2)) ;
p = 2*normpdf((1/v)-zalpha)















end