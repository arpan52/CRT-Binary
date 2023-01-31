
function step_11(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l)
    global iteration_num;
al1=0.9;
al2=0.2;
N=50;
m=6;   
    theta_argmax_psi = zeros(m); psi_max = -inf;
    stopping=true;
    
    for i=1:1:1        
        %initialization of theta_nod according to (0.8,1.1) limit
        theta_nod = rand(1,2)+(0.8);
        x1=design_l(1);
        x2=design_l((m/2)+1);
        
        options = optimoptions('fmincon','Display','none');
        
        [this_theta_psi_max, this_psi_max] = fmincon(@(theta) -((1/((exp(theta(1))/((1+exp(theta(1))).^2))*((m/2)*x1/((x1-(1/N))*al1+(1/N)))))+(1/(( exp(theta(1)+theta(2))/((1+exp(theta(1)+theta(2))).^2))*((m/2)*x2/((x2-(1/N))*al2+(1/N)))))), theta_nod, [],[], [], [], [-3 -3], [3 3],[],options);
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
        theta_l1 = theta_argmax_psi;
        step_2(H,h_grid_space,theta_l,prob_l,design_l,B_pi_l,theta_l1);
    end
end



