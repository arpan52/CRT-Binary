function y = var_cluster_trt_diff_m(x,mu,beta,al1,al2,N,m1,m2)
% mu=0.1;
% beta=0.3;
% al1=0.3;
% al2=0.2;
% N=50;
% m=6;
 a1 = [];
 a2 = [];
% x = [0.1 0.2 0.1 0.3 0.2 0.1];
for i = 1:1:m1
    a1(i) = x(i)./((x(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x(j)./((x(j) - 1./N)*al2 + 1./N);
end
 var1 = exp(mu)/((1+exp(mu))^2);
 var2 = exp(mu+beta)/((1+exp(mu+beta))^2);
y = 1/(var1*sum(a1)) + 1/(var2*sum(a2));
