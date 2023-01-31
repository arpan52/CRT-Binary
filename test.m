function ret_val = get_optimal_on_the_average_design1(theta_vals, prob_vals);

m=6;

des_0=[0.1 0.23];
%des_0 = [ (0.8/m)*ones(1,m/2),(1.2/m)*ones(1,m/2) ]; nseq=m;options = optimoptions('fmincon','Display','none');
    opt_design = fmincon(@(des)B1(des,theta_vals, prob_vals), des_0, [],[], [m/2,m/2], [1.0], zeros(2,1), ones(2,1),[])
for i=1:m/2
    opt_design1(i)=opt_design(1);
   opt_design1(i+m/2)=opt_design(m/2+1);
end
ret_val = opt_design1;
end