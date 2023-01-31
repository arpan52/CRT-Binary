function step_41(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l) 
   m=6;
   design_l12(1)=design_l1(1);
   design_l12(2)=design_l1((m/2)+1);
   B_pi_l1 = B1(design_l12, theta_vals_l1, prob_vals_l1);
    if B_pi_l1 > B_pi_l
        B_pi_l = B_pi_l1;
        design_l = design_l1;
        "Assigned l1 to l";
        theta_l = theta_vals_l1;
        prob_l = prob_vals_l1; 
        step_11(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l);
    else
        h_grid_space = h_grid_space/2.0;
        H = 0.0:h_grid_space :1.0;
        step_31(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l,theta_l);
    end
end