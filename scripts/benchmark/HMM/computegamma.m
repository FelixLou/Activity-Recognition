function [gamma ] = computegamma( N, M, A, B, pi, O,alpha, beta) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence
%alpha:forward matrix
%beta:backward matrix
T = size(O,2);
for t = 1:1:T
    denominator = 0.0;
    for j = 1:1:N
        gamma(t,j)=alpha(t,j)*beta(t,j);
        denominator = denominator + gamma(t,j);
    end
    for i = 1:1:N
        gamma(t,i)=gamma(t,i)/denominator;
    end
end
