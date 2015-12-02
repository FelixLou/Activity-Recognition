function [ beta ] = backward( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence

T = size(O,2);

for i = 1:1:N
    beta(T,i)=1.0;
end

for t = T-1:-1:1
    for i = 1:1:N
        sum = 0.0;
        for j = 1:1:N
            sum = sum + A(i,j)*B(j,O(t+1))*beta(t+1,j);
        end
        beta(t,i) = sum;
    end
end

pprob = 0.0;
for i = 1:1:N
    pprob = pprob + beta(1,i);
end
