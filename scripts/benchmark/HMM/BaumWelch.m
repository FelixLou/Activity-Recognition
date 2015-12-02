function [probfinal,A,B,pi] = BaumWelch( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix N*N
%B:emissions matrix  N*M
%pi:initial vector   N
%O;observed sequence 

[probf, alpha]=forward(N,M,A,B,pi,O);
beta = backward(N,M,A,B,pi,O);
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
    [probf, alpha]=forward(N,M,A,B,pi,O);
    beta = backward(N,M,A,B,pi,O);
    gamma = computegamma(N,M,A,B,pi,O,alpha,beta);
    xi = computexi(N,M,A,B,pi,O,alpha,beta);

    delta = probf - probprev;
    probprev = probf;
    l = l + 1;
    a =1
    if(delta <= 0.00000001 || l > 50 ) 
        break;
    end
end
probfinal = probf;
l
 
        