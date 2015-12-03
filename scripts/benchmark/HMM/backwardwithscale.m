function [ beta ] = backwardwithscale( N, M, A, B, pi, O,scale) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence
%scale: scale matrix

T = size(O,2);

for i = 1:1:N
    beta(T,i)=1.0 / scale(T);
end

for t = T-1:-1:1
    count = 0;
    for i = 1:1:N
        sum = 0.0;
        for j = 1:1:N
            sum = sum + A(i,j)*B(j,O(t+1))*beta(t+1,j);
        end
        beta(t,i) = sum / scale(t);
        if(beta(t,i)==0)
            count = count + 1;
        end
    end
    if(count == N)
        beta(t,i) = 1 / scale(t);
    end
end


