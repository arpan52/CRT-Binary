function step_31(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l,theta_l1)
   m=6;
   design_l1 = design_l;
    largest_B_pi_t_l1 = -inf;
    prob_vals_l1 = prob_l
    theta_vals_l1 = theta_l
    
    theta_l;
    prob_l;
    
    for t_val=1:1:length(H)
        theta_vals_t_l1 = [theta_l; theta_l1];
        %"old"
        %prob_vals_l1
        prob_vals_t_l1 = [(1-H(t_val)).*prob_l H(t_val)];
        %"H(t_val)"
        %H(t_val)
        %"new"
        %prob_vals_t_l1
        
        design_t_l1 = get_optimal_on_the_average_design1(theta_vals_t_l1, prob_vals_t_l1);
       design_t1_l1=design_t_l1(1);
       design_t1_l1=design_t_l1((m/2)+1);
        B_pi_t_l1 = B1(design_t1_l1, theta_vals_t_l1, prob_vals_t_l1);        
        if largest_B_pi_t_l1<B_pi_t_l1
            largest_B_pi_t_l1 = B_pi_t_l1;
            design_l1 = design_t_l1;
            prob_vals_l1 = prob_vals_t_l1;
            theta_vals_l1 = theta_vals_t_l1;
        end
    end
    step_41(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l)    
end