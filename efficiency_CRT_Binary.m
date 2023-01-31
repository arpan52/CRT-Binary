% scenario 1
 m1 = 5;
 m2 = 10;
 N =150;
 mu = 0.5;
 beta = -1;
 x_bal = 0.067*ones(m1+m2,1);
 x_lod = [0.111*ones(m1,1);0.044*ones(m2,1)];
 x_u = [0.054*ones(m1,1);0.072*ones(m2,1)];
 x_n = [0.097*ones(m1,1);0.051*ones(m2,1)];
 x_mm = [0.021*ones(m1,1);0.090*ones(m2,1)];
 
  % scenario 2
  
%    m1 = 5;
%  m2 = 15;
%  N =250;
%  mu = 0.5;
%  beta = -1;
%  
%  x_bal = 0.050*ones(m1+m2,1);
%  x_lod = [0.111*ones(m1,1);0.029*ones(m2,1)];
%  x_u = [0.109*ones(m1,1);0.030*ones(m2,1)];
%  x_n = [0.054*ones(m1,1);0.049*ones(m2,1)];
%  x_mm = [0.090*ones(m1,1);0.037*ones(m2,1)];
for i=1:1:5000
  al1 = 0.01 + (0.2-0.01).*rand(1);
  al2 = 0.3 + (0.6-0.3).*rand(1);
 

  v_bal(i) = var_cluster_trt_diff_m(x_bal,mu,beta,al1,al2,N,m1,m2);
  v_lod(i) = var_cluster_trt_diff_m(x_lod,mu,beta,al1,al2,N,m1,m2);
  v_u(i) = var_cluster_trt_diff_m(x_u,mu,beta,al1,al2,N,m1,m2);
  v_n(i) = var_cluster_trt_diff_m(x_n,mu,beta,al1,al2,N,m1,m2);
  v_mm(i) = var_cluster_trt_diff_m(x_mm,mu,beta,al1,al2,N,m1,m2);
  eff_lod(i) = sqrt(v_lod(i)/v_bal(i));
  eff_u(i) = sqrt(v_u(i)/v_bal(i));
  eff_n(i) = sqrt(v_n(i)/v_bal(i));
  eff_mm(i) = sqrt(v_mm(i)/v_bal(i));

 
end
% efficiency figure
figure(1)
boxplot([eff_lod',eff_u',eff_n',eff_mm'],'labels',{'$$\Gamma(\xi_{LOD})$$','$$\Gamma(\xi_{B}^{U})$$','$$\Gamma(\xi_{B}^{N})$$','$$\Gamma(\xi_{MM})$$'});

bp = gca;

bp.XAxis.TickLabelInterpreter = 'latex';
%ylabel('Efficiency') 

% variance figure

% figure(1)
% boxplot([v_lod',v_u',v_n',v_mm',v_bal'],'labels',{'$$\phi(\xi_{LOD})$$','$$\phi(\xi_{B}^{U})$$','$$\phi(\xi_{B}^{N})$$','$$\phi(\xi_{MM})$$','$$\phi(\xi_{Bal})$$'});
% 
% bp = gca;
% 
% bp.XAxis.TickLabelInterpreter = 'latex';
%ylabel('Efficiency') 