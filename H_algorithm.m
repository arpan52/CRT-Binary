% H-ALGORITHM :
clear all;
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
theta_vals_l = [ ones(1,2) ]
prob_vals_l = [1.0]

% Initial Prior PMF is (theta_vals, prob_vals)
"Starting Design";
design_l = get_optimal_on_the_average_design(theta_vals_l,prob_vals_l)
B_pi_l = B(design_l, theta_vals_l, prob_vals_l);

%step 1
step_1(H,h_grid_space,theta_vals_l,prob_vals_l,design_l,B_pi_l)






