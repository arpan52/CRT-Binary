function y = fmin1diff_m(k1,k2,x,al1,al2,N,m1,m2)
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

 
y = (k1/(sum(a1))) +( k2/(sum(a2)));



