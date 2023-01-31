function y = fmin2(k0,z1,z2,x,N,m,al1,al2)
 a1 = [];
 a2 = [];
for i = 1:m
    a1(i) = x(i)./((x(i) - 1./N)*al1 + 1./N);
    a2(i) = x(m+i)./((x(m+i) - 1./N)*al2 + 1./N);
end
y=k0.*(z1/(sum(a1)))+(z2/(sum(a2)));
end