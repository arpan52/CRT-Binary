x = 0:.1:0.3; 
count=0;

for i=1:length(x)
    for j=1:length(x)
        for k=1:length(x)
            t1=f(x(j),x(k));
            l = f(x(i),t1);
            t2=f(x(i),x(j));
            m = f(t2,x(k));
              if ((l)~=(m))
                  count=count+1;
%                   i
%                   j
%                   k
%                   t1
%                   t2
                  l
                  m
                
%                     formatSpec = 'LHS = %2f ~= %2f = RHS \n';
%                     fprintf(formatSpec,LHS,RHS)
              end
           
        end
    end
end
count
