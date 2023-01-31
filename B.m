function ret_val = B (design, theta_vals, prob_vals)
    s = 0;
    m=6;
    
   for i = 1:length(prob_vals)
        s = s + prob_vals(i)*(psi1( design, theta_vals(i,:)) );
    end
    ret_val=s;
end