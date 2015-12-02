function [ pprob, alpha ] = forward( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence

for i = 1:1:N
    alpha(1,i)=pi(i)*B(i,O(1));
end

for t = 1:1:(size(O,2)-1)
    for j = 1:1:N
        sum = 0.0;
        for i = 1:1:N
            sum = sum + alpha(t,i)*A(i,j);
        end
        alpha(t+1,j) = sum * B(j,O(t+1));
    end
end

pprob = 0.0;
for i = 1:1:N
    pprob = pprob + alpha(size(O,2),i);
end

        
        
        
        