function [xi] = computexi( N, M, A, B, pi, O,alpha, beta)
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence
%alpha:forward matrix
%beta:backward matrix
T = size(O,2);

for t = 1:1:T-1
    sum = 0.0;
    for i = 1:1:N
        for j = 1:1:N
            xi(t,i,j)=alpha(t,i)*beta(t+1,j)*A(i,j)*B(j,O(t+1));
            sum = sum + xi(t,i,j);
        end
    end
    
    for i = 1:1:N
        for j = 1:1:N
            xi(t,i,j) = xi(t,i,j)/sum;
        end
    end
end