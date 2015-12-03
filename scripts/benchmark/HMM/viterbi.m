function [pprob,q] = viterbi( N, M, A, B, pi, O) 
%N:number of Hidden state
%M:number of Emissions
%A:transition matrix
%B:emissions matrix
%pi:initial vector
%O;observed sequence

for i = 1:1:N
    delta(1,i)=pi(i)*B(i,O(1));
    psi(1,i) = 0;
end

T = size(O,2);
for t = 2:1:T
    for j = 1:1:N
        maxval = 0.0;
        maxvalind = 1;
        for i = 1:1:N
            val = delta(t-1,i)*A(i,j);
            if(val > maxval)
                maxval = val;
                maxvalind = i;
            end
        end
        delta(t,j) = maxval * B(j,O(t));
        psi(t,j) = maxvalind;
    end
end
psi

pprob = 0.0;
q(T) = 1;
for i = 1:1:N
    if(delta(T,i) > pprob)
        pprob = delta(T,i);
        q(T) = i;
    end
end

for t = (T-1):-1:1
    q(t) = psi(t+1,q(t+1));
end

        
       