function y = fmin2diff_m(k0,z1,z2,x,N,m1,m2,al1,al2)
 a1 = [];
 a2 = [];
for i = 1:1:m1
    a1(i) = x(i)./((x(i) - 1./N)*al1 + 1./N);
end
for j=m1:1:(m1+m2)
    a2(j) = x(j)./((x(j) - 1./N)*al2 + 1./N);
end
y=k0.*(z1/(sum(a1)))+(z2/(sum(a2)));
