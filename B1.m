function ret_val = B1 (design, theta_vals, prob_vals)
    s = 0;
al1=0.9;
al2=0.2;
N=50;
m=6;
x1=design(1);
x2=design(2);

% beta0=1;
% al=1;
%finding the locally optimal designs analytically

%psi function
    
   for i = 1:length(prob_vals)
       mu=theta_vals(i,1);
       beta=theta_vals(i,2);
       gamma1 = exp(mu)/((1+exp(mu))^2);
       gamma2 = exp(mu+beta)/((1+exp(mu+beta))^2);
       m1=m/2;
 s = s + prob_vals(i)*((1/(gamma1*((m1*x1)/((x1-(1/N)*al1)+(1/N)))))+(1/(gamma2*((m1*x2)/((x2-(1/N)*al2)+(1/N))))) );
    end
    ret_val=s;
end