
function step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l)
    global iteration_num;
m=6;
    p=2;
    theta_argmax_psi = zeros(m); psi_max = -inf;
    stopping=true;
    
    for i=1:1:1        
        %initialization of theta_nod according to (0.8,1.1) limit
        theta_nod = 0.3*rand(1,2)+(0.8);
        
        options = optimoptions('fmincon','Display','none');
        
        [this_theta_psi_max, this_psi_max] = fmincon(@(theta) -psi1(design_l,theta), theta_nod, [],[], [], [], [0 0], [2 2],[],options);
        this_psi_max = -1.0*this_psi_max;
        if this_psi_max > psi_max
            psi_max = this_psi_max;
            theta_argmax_psi = this_theta_psi_max;
        end
    end
    iteration_num
    iteration_num = iteration_num+1;
    psi_max
    B_pi_l
    if psi_max>B_pi_l
        stopping=false;
    end
              
    if stopping==true
        "Found minmax design"
        design_l
        "Least Favourable Distribution"
        "probs"
        prob_vals_l
        "thetas"
        theta_vals_l
    else
        theta_l = theta_argmax_psi;
        step_2(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l);
    end
end
