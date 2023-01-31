clear all;
%solving for value of 'K'(lowest eigenvalue)
k0=8;     %assign the value of k0 
k1=0;     %assign the value of k1
n=4;      %assign the value of 'n'(number of terms included in the series)
q=0.8;    %assign the value of 'phi' as 'q'
a=0.5;    %assign the value of 'alpha'(aspect ratio)as 'a'
m=1;      %assign some fix number
v=0.27;   %assign the value of poisson's ratio of the plate material

%k0=input('enter the value of k0 :');
%k1=input('enter the value of k1 :');
%n=input('enter the number of terms included in series:');
%q=input('enter the value of phi :');
%a=input('enter the value of aspect ratio alpha :');
%m=input('enter the value of m :');

b=((2-v)*m^2*pi^2)/q^2;         %constant
c=(v*m^2*pi^2)/q^2;             %constant

A=[1,2,4,8;2*(n+3)*((n+2)+k0/2),4*(n+2)*((n+1)+k0/2),8*(n+1)*(n+k0/2),16*n*((n-1)+k0/2);2*c-8*(n+3)*(n+2),16*(n+2)*(n+1)-4*c,8*c-32*(n+1)*n,64*n*(n-1)-16*c;2*b*(n+3)-8*(n+3)*(n+2)*(n+1),16*(n+2)*(n+1)*n-4*b*(n+2),8*b*(n+1)-32*(n+1)*n*(n-1),64*n*(n-1)*(n-2)-16*n*b];
B=[-1/2;-(n+4)*((n+3)+k0/2);c-4*(n+4)*(n+3);b*(n+4)-4*(n+4)*(n+3)*(n+2)];
X=A\B;                          %to calculate the cofficients in deflection series 

Y=zeros(n+1,1);                 %to write the expression of series 'Y'
syms Y
syms r
for i=0:n                       %for loop for storing the values in Y=zeros(n+1,1)
    C=[r^(i+3),r^(i+2),r^(i+1),r^i];
    Y(i+1,1)=C*X + r^(i+4);
end

c1=(2*m^2*pi^2)/q^2;              %constant
c2=(m^4*pi^4)/q^4;                %constant
c3=(m^2*pi^2)/q^2;                %constant

L=zeros(n+1);                     %to create the matrix 'L'
M=zeros(n+1);                     %to create the matrix 'M'
syms L
syms M
for j=0:n                         %for loops to storing the values in 'L'&'M'
    for p=0:n
        t2=(diff(Y(p+1,1),r,4)-c1*diff(Y(p+1,1),r,2)+c2*Y(p+1,1))*Y(j+1,1);
        t1=int(t2,r,-1/2,1/2);
        L(p+1,j+1)=t1;
        
        t3=(c3*((1-a/2)+a*r)*Y(p+1,1))*Y(j+1,1);
        t4=int(t3,r,-1/2,1/2);
        M(p+1,j+1)=t4;
        
    end
end

% H=L/M;
H1=inv(L)*M;
%K=eig(H);    % basically 'eig(H)' will calculate all eigenvalues but our interest is in only lowest eigenvalue   
 k= power_method1(H1,0.001)
%  vpa(k)





