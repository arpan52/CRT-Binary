

% H-ALGORITHM : 
warning off;

p=2;
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
theta_vals_l = [ ones(1,1+p+1) ]
prob_vals_l = [1.0]

% Initial Prior PMF is (theta_vals, prob_vals)
"Starting Design"; 
design_l = get_optimal_on_the_average_design(theta_vals_l,prob_vals_l)
B_pi_l = B(design_l, theta_vals_l, prob_vals_l);

step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l)

function step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l)
    global iteration_num;

    p=2;
    theta_argmax_psi = [0.0 0.0 0.0 0.0 0.0]; psi_max = -inf;
    stopping=true;
    
    for i=1:1:1        
        %initialization of theta_nod according to (0.8,1.1) limit
        theta_nod = 0.3*rand(1,1+p+1)+(0.8);
        options = optimoptions('fmincon','Display','none');
        [this_theta_psi_max, this_psi_max] = fmincon(@(theta) -psi(design_l,theta), theta_nod, [],[], [], [], [-1 0.8 -0.3 1.0], [1 1.2 0.7 5.4],[],options);
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

function step_2(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l)
    %delta_l = unit mass to theta_l
    step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l);
end

function step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l)
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
        
        design_t_l1 = get_optimal_on_the_average_design(theta_vals_t_l1, prob_vals_t_l1);
        B_pi_t_l1 = B(design_t_l1, theta_vals_t_l1, prob_vals_t_l1);        
        if largest_B_pi_t_l1<B_pi_t_l1
            largest_B_pi_t_l1 = B_pi_t_l1;
            design_l1 = design_t_l1;
            prob_vals_l1 = prob_vals_t_l1;
            theta_vals_l1 = theta_vals_t_l1;
        end
    end
    step_4(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l)    
end

function step_4(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,design_l1, theta_vals_l1, prob_vals_l1, theta_l) 
    B_pi_l1 = B(design_l1, theta_vals_l1, prob_vals_l1);
    if B_pi_l1 > B_pi_l
        B_pi_l = B_pi_l1;
        design_l = design_l1;
        "Assigned l1 to l";
        theta_vals_l = theta_vals_l1;
        prob_vals_l = prob_vals_l1; 
        step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l);
    else
        h_grid_space = h_grid_space/2.0;
        H = 0.0:h_grid_space :1.0;
        step_3(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l,theta_l);
    end
end

function ret_val = get_least_favourable_argument(design)
    p=2;
    arg_0 = 10*rand(1,1+p+1);options = optimoptions('fmincon','Display','none');
    l_f_arg=fmincon(@(theta) -psi(design,theta), arg_0, [],[], [], [], [-1 0.8 -0.3 1.0], [1 1.2 0.7 5.4],[],options);
    %l_f_arg = fmincon(@(theta)-1* psi(design,theta), arg_0, [],[],[],options);
    ret_val = l_f_arg;
end

function ret_val = get_optimal_on_the_average_design(theta_vals, prob_vals)
    des_0 = [ 0.1 0.2 0.3 0.4 ]; nseq=4;options = optimoptions('fmincon','Display','none');
    opt_design = fmincon(@(des)B(des,theta_vals, prob_vals), des_0, [],[], ones(1,nseq), [1.0], zeros(nseq,1), ones(nseq,1),[],options);
    ret_val = opt_design;
end

function ret_val = B (design, theta_vals, prob_vals)
    s = 0;
    for i = 1:length(prob_vals)
        s = s + prob_vals(i)* psi( design, theta_vals(i,:) );
    end
    ret_val=s;
end
function y = psi(design,theta)
    p = 2; %periods
    rho = 0.5; %Cross-Correlation Coefficient

    % Xj for j= 1,2,3,4 corresponds to X_AA,X_AB,X_BA,X_BB respectively
    X1 = [ ones(p,1) [1;-1] [1;1] [0;1] ];
    X2 = [ ones(p,1) [1;-1] [1;-1] [0;1] ];
    X3 = [ ones(p,1) [1;-1] [-1;1] [0;-1] ];
    X4 = [ ones(p,1) [1;-1] [-1;-1] [0;-1] ];

    % parameters in one column
    % theta = [mu;beta;tau;gam];
       
    % formula for Linear Predictor : n_j = Xj * theta
    n1 = X1*theta';
    n2 = X2*theta';
    n3 = X3*theta';
    n4 = X4*theta';

    % using inverse logit link to obtain u_ij. Formula : g(u_ij) = n_ij |
    % where u_ij is mean of response variable
    u1 = exp(n1)./(1.+exp(n1));
    u2 = exp(n2)./(1.+exp(n2));
    u3 = exp(n3)./(1.+exp(n3));
    u4 = exp(n4)./(1.+exp(n4));

    % Aj = diag ( Var(Y1j), . . . , Var(Ypj) )
    % As Y_ij is Bernoulli Variable for our case, Var(Y_ij) = u_ij * (1 - u_ij)
    % Define Aj in line after eqn 3. For Bernoulli Case, Aj = Dj as defined on pg 38 line  3
    A1 = diag(u1.*(1.-u1));
    A2 = diag(u2.*(1.-u2));
    A3 = diag(u3.*(1.-u3));
    A4 = diag(u4.*(1.-u4));

    % Defining Correlation Matrix R(alpha)
    R = rho*ones(p)+(1-rho)*eye(p);
    % Storing Inverse of R(alpha)
    R_inv = inv(R);
    
    %print("Length of design")
    design;
    asymptotic_information_matrix = design(1)*X1'*sqrt(A1)*R_inv*sqrt(A1)*X1 + design(2)*X2'*sqrt(A2)*R_inv*sqrt(A2)*X2 + design(3)*X3'*sqrt(A3)*R_inv*sqrt(A3)*X3 + design(4)*X4'*sqrt(A4)*R_inv*sqrt(A4)*X4;
    %n = 1e12;
    %asymptotic_information_matrix = n.* asymptotic_information_matrix;
    asymptotic_variance = inv(asymptotic_information_matrix);
    C = asymptotic_variance(3,3);
    y = C;
    %y = 1/log(det(asymptotic_information_matrix));
end
H_Algo_bred.m
Displaying H_Algo_bred.m.