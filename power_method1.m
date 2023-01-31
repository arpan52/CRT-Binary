function l = power_method1(A,E)
n = length(A);
y = [];
x = [];
for i = 1:n            % starting vector
    x(i) = A(i,1);
end;
l = 0;
eps = E;        % starting value of error
while eps>=E
      for i = 1:n    % A*x
          y(i) = 0;
          for j = 1:n
              y(i) = y(i) + A(i,j)*x(j);
          end;
      end;
      eps = l;
      l = 0;           % Rayleigh
      m = 0;
      for i = 1:n
          l = l + x(i)*y(i);
          m = m + x(i)*x(i);
      end;
      l = l/m;           % eigenvalue
      eps = abs(l - eps);         % error
      x = y;
  end;
end