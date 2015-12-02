
% stateNumber = length(unique(resultmean.pred{1,1}));
% obsNumber = stateNumber;
% tranMatrix = zeros(stateNumber,stateNumber);
% emitMatrix = zeros(stateNumber,obsNumber);
pi = ones(6)/6
%obeserveSequence = resultmean.actCls{1,1};
%[probfinal,A,B,pi] = BaumWelch(stateNumber, obsNumber, tranMatrix, emitMatrix, pi, obeserveSequence); 