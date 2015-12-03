%predLabel: Label used for the traning of HMM.
%testLabel: Label for testing
function y = buildHMM(predLabel,actualLabel,trainFeatureLabel,testLabel)
    trainLabel = unique(trainFeatureLabel);
    stateNumber = length(trainLabel);
    predictNumber = length(unique(predLabel));
    tranMatrix = zeros(stateNumber);
    emitMatrix = zeros(stateNumber,predictNumber);
    %redo labeling, label start from 1 to N,total number of labels.
    for i=1:stateNumber
        trainFeatureLabel(trainFeatureLabel==trainLabel(i))=i;
        predLabel(predLabel==trainLabel(i))=i;
        actualLabel(actualLabel==trainLabel(i))=i;
        testLabel(testLabel==trainLabel(i))=i;
    end
    %construct the transition matrix and emission matrix
    for i=2:length(trainFeatureLabel)
        tranMatrix(trainFeatureLabel(i-1),trainFeatureLabel(i))=...
            tranMatrix(trainFeatureLabel(i-1),trainFeatureLabel(i))+1;
    end
    for i=1:length(predLabel)
        emitMatrix(actualLabel(i),predLabel(i))=...
            emitMatrix(actualLabel(i),predLabel(i))+1;
        %display(i);
    end
    
    %Normalization
    for i=1:stateNumber
        tranMatrix(i,:)=tranMatrix(i,:)/sum(tranMatrix(i,:));
        emitMatrix(i,:) = emitMatrix(i,:)/sum(emitMatrix(i,:));
    end
    
%    y=hmmviterbi(testLabel',tranMatrix,emitMatrix);
    pi = ones(stateNumber)/stateNumber;
    %tranMatrix = ones(6,6)/6;
    %emitMatrix = ones(6,6)/6;
    [probfinal,A,B,pi] = BaumWelch(stateNumber,stateNumber, tranMatrix,emitMatrix,pi,testLabel');
    [prob, y] = viterbi(stateNumber,stateNumber, A,B,pi,testLabel');
    
    %[prob, y] = viterbi(stateNumber,stateNumber, tranMatrix,emitMatrix,pi,testLabel');
    %y = hmmdecode(testLabel',tranMatrix,emitMatrix);
    y = trainLabel(y);
end