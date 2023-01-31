 clear all;
 mu=1 ;
%beta=3;
al1=0.9;
al2=0.2;
N=50;
m=30;
beta0=0;
al=0.05;
%finding the locally optimal designs analytically
i=1;
for beta=[1:0.2:5]
     if(i<=21)
p1 = exp(mu)/(((1+exp(mu))^2)*(al1-1));
p2 = exp(mu+beta)/(((1+exp(mu+beta))^2)*(al2-1));
m1=m/2;

y=(1/m1)*(1/(1+sqrt(p1/p2)));
z= (1 - m1*y)/m1;

for j=1:m/2
    x(i,j)=y;
    x(i,j+m/2)=z;
end
     end
 i=i+1;
    end

x
[pr1,pr2]=pwr1(m,N,al1,al2,x,mu,beta,al,beta0) 
%plot the graphs
beta=[1:0.2:5];
   plot(beta,pr1,'.')
 xlim([1 5])
 ylim([0 1])
  xlabel('beta') 
ylabel('power of design')
hold on;

  plot(beta,pr2,'.')
      xlim([1 5])
  ylim([0 1])
   

hold off
