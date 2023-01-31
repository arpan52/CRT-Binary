

% H-ALGORITHM : 
warning off;
 al1=0.05;
 al2=0.4;
 N=250;
 m1=5;
 m2 =15;


global iteration_num
iteration_num=0;

%Step 0

l=1; B_pi_l = -inf;
h_grid_space = 0.05;
H = 0.0:h_grid_space:1.0;
%theta = [mu;beta;tau;gam];
%theta_vals_l = [ ones(1,1+p+1) ; zeros(1,1+p+1)];
%For prior distribution, assigning equal prob mass to both theta
%prob_vals_l = [0.5, 0.5];
"Initial Prior on Theta : "
theta_vals_l = 0.2*ones(1,2);
prob_vals_l = 1.0;

% Initial Prior PMF is (theta_vals, prob_vals)
"Starting Design"; 
design_l = get_optimal_on_the_average_design(theta_vals_l,prob_vals_l, m1, m2, al1, al2, N)
B_pi_l = B(design_l, theta_vals_l, prob_vals_l, m1, m2, al1, al2, N);

step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l, m1, m2, al1, al2, N)

function step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l, m1, m2, al1, al2, N)
    global iteration_num;

    theta_argmax_psi = [0.0 0.0]; psi_max = -inf;
    stopping=true;
    
    for i=1:1:1        
        %initialization of theta_nod according to (0.8,1.1) limit
        %theta_nod = 0.3*rand(1,2)+(0.8);
        theta_nod = [1 1];
        options = optimoptions('fmincon','Display','none');
        [this_theta_psi_max, this_psi_max] = fmincon(@(theta) -psi1(design_l,theta, m1, m2, al1, al2, N), theta_nod, [],[], [], [], [0.2 -3], [2 5],[],options);
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
        step_2(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l, m1, m2, al1, al2, N);
    end
end

function step_2(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l, m1, m2, al1, al2, N)
    %delta_l = unit mass to theta_l
    step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l, m1, m2, al1, al2, N);
end

function step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l, m1, m2, al1, al2, N)

design_l1 = design_l;
    largest_B_pi_t_l1 = -inf;
    prob_vals_l1 = prob_vals_l
    theta_vals_l1 = theta_vals_l
    
    theta_vals_l;
    prob_vals_l;
    
    for t_val=1:1:length(H)
        theta_vals_t_l1 = [theta_vals_l; theta_l];
        %"old"
        %prob_vals_l1
        prob_vals_t_l1 = [(1-H(t_val)).*prob_vals_l H(t_val)];
        %"H(t_val)"
        %H(t_val)
        %"new"
        %prob_vals_t_l1
        
        design_t_l1 = get_optimal_on_the_average_design(theta_vals_t_l1, prob_vals_t_l1, m1, m2, al1, al2, N);
        B_pi_t_l1 = B(design_t_l1, theta_vals_t_l1, prob_vals_t_l1, m1, m2, al1, al2, N);        
        if largest_B_pi_t_l1<B_pi_t_l1
            largest_B_pi_t_l1 = B_pi_t_l1;
            design_l1 = design_t_l1;
            prob_vals_l1 = prob_vals_t_l1;
            theta_vals_l1 = theta_vals_t_l1;
        end
    end
    step_4(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l, m1, m2, al1, al2, N)    
end

function step_4(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l, m1, m2, al1, al2, N) 

B_pi_l1 = B(design_l1, theta_vals_l1, prob_vals_l1, m1, m2, al1, al2, N);
    if B_pi_l1 > B_pi_l
        B_pi_l = B_pi_l1;
        design_l = design_l1;
        "Assigned l1 to l";
        theta_vals_l = theta_vals_l1;
        prob_vals_l = prob_vals_l1; 
        step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l, m1, m2, al1, al2, N);
    else
        h_grid_space = h_grid_space/2.0;
        H = 0.0:h_grid_space :1.0;
        step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l, m1, m2, al1, al2, N);
    end
end

% function ret_val = get_least_favourable_argument(design)
% 
%     arg_0 = 10*rand(1,2);options = optimoptions('fmincon','Display','none');
%     l_f_arg=fmincon(@(theta) -psi1(design,theta), arg_0, [],[], [], [], [-2 -2], [2 2],[],options);
%     %l_f_arg = fmincon(@(theta)-1* psi(design,theta), arg_0, [],[],[],options);
%     ret_val = l_f_arg;
% end

function ret_val = get_optimal_on_the_average_design(theta_vals, prob_vals, m1, m2, al1, al2, N)
%  m1=5;
%  m2=5;   
 des_0 = [ (0.4/m1)*ones(1,m1),(0.6/m2)*ones(1,m2) ];

nseq=(m1+m2);options = optimoptions('fmincon','Display','none');
    opt_design = fmincon(@(des)B(des,theta_vals, prob_vals,m1, m2, al1, al2, N), des_0, [],[], ones(1,nseq), [1.0], zeros(nseq,1), ones(nseq,1),[],options);
    ret_val = opt_design;
end

function ret_val = B(design, theta_vals, prob_vals, m1, m2, al1, al2, N)  
s = 0;
    for i = 1:length(prob_vals)
        s = s + prob_vals(i)* psi1( design, theta_vals(i,:), m1, m2, al1, al2, N);
    end
    ret_val=s;
end



function y = psi1(design, theta, m1, m2, al1, al2, N)
% m1=5;
% m2=5;
% N=100;
s1=0;
s2=0;
% al1=0.1;
% al2=0.3;
for i=1:1:m1
    s1=s1+(design(i)/((design(i)-(1/N))*al1+(1/N)));
end
for j=(m1)+1:1:(m1+m2)
    s2=s2+(design(j)/((design(j)-(1/N))*al2+(1/N)));
end
gamma1 = exp(theta(1))/((1+exp(theta(2))).^2);
gamma2 = exp(theta(1)+theta(2))/((1+exp(theta(1)+theta(2))).^2);

psi=(1/(gamma1*s1))+(1/(gamma2*s2));

y=psi;

end
