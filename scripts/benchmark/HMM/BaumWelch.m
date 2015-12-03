function [probfinal,A,B,pi] = BaumWelch( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence

[probf, alpha,scale]=forwardwithscale(N,M,A,B,pi,O);

beta = backwardwithscale(N,M,A,B,pi,O,scale);
gamma = computegamma(N,M,A,B,pi,O,alpha,beta);
xi = computexi(N,M,A,B,pi,O,alpha,beta);
probprev = probf;
l = 0;
T = size(O,2);

while(1)
    for i = 1:1:N
        pi(i) = 0.001 + 0.999*gamma(1,i);
    end
    for i = 1:1:N
        denominatorA = 0.0;
        for t = 1:1:T-1
            denominatorA = denominatorA + gamma(t,i);
        end

        for j = 1:1:N
            numeratorA = 0.0;
            for t = 1:1:T-1
                numeratorA = numeratorA + xi(t,i,j);
            end
            A(i,j) = 0.001 + 0.999*numeratorA/denominatorA;
        end
        
        denominatorB = denominatorA + gamma(T,i);
        for k = 1:1:M
            numeratorB = 0.0;
            for t = 1:1:T
                if(O(t) == k)
                    numeratorB = numeratorB + gamma(t,i);
                end
            end
            B(i,k) = 0.001 + 0.999*numeratorB/denominatorB;
        end
    end

    [probf, alpha,scale]=forwardwithscale(N,M,A,B,pi,O);
    beta = backwardwithscale(N,M,A,B,pi,O,scale);
    gamma = computegamma(N,M,A,B,pi,O,alpha,beta);
    xi = computexi(N,M,A,B,pi,O,alpha,beta);

    delta = probf - probprev;

    probprev = probf;
    l = l + 1;
    l
    delta
    if(delta <= 10^-15)
     
        break;
    end
end
probfinal = probf;
 
        