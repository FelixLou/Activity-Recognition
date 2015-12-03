function [ pprob ,alpha, scale] = forwardwithscale( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence
scale(1) = 0.0;
T = size(O,2);
for i = 1:1:N
    alpha(1,i)=pi(i)*B(i,O(1));
    scale(1) = scale(1) + alpha(1,i);
end

for i = 1:1:N
    alpha(1,i) = alpha(1,i) / scale(1);
end
for t = 1:1:T-1
    scale(t+1)=0.0;
    if(t == 76)
        i2 = 1;
    end
        
    for j = 1:1:N
        sum = 0.0;
        for i = 1:1:N
            sum = sum + alpha(t,i)*A(i,j);   
        end

        alpha(t+1,j) = sum * B(j,O(t+1));
        scale(t+1) = scale(t+1) + alpha(t+1,j);
    end
    for j = 1:1:N
        if(scale(t+1) == 0)
            scale(t+1) = 1;
            if(j == 1)
                alpha(t+1,j) = 1;
            else
                alpha(t+1,j) = 0;
            end
        else
            alpha(t+1,j) = alpha(t+1,j)/scale(t+1);
        end
    end
end

pprob = 0.0;
for t = 1:1:T
    if(scale(t) == 0)
        ii = 1
    end
    pprob = pprob + log(scale(t));
end


        
        
        
        