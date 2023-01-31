function y2 = part2(a11,b12,c21,d22,mu,beta)

y2=((((1+exp(mu+beta)).^2)./(exp(mu+beta))).*(exp((-(mu).^2)./(2.*(b12.^2)))).*(exp((a11.*mu)./(b12.^2))).*(exp((-(beta).^2)./(2.*(d22.^2)))).*(exp((c21.*beta)./(d22.^2))));
 


end
