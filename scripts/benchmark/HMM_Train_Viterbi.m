%predLabel: Label used for the traning of HMM.
%actualLabel: Actual label for the traning of HMM.
%testLabel: Label for testing 
%trainFeatureLabel:Label for all train sets
%y:predict label by the hmm model
function y = HMM_Train_Viterbi(predLabel,actualLabel,trainFeatureLabel,testLabel)
    trainLabel = unique(trainFeatureLabel);
    stateNumber = length(trainLabel);
    predictNumber = length(unique(predLabel));
    tranMatrix = zeros(stateNumber);
    emisMatrix = zeros(stateNumber,predictNumber);
    %re-label states from 1 to N
    for i=1:stateNumber
        trainFeatureLabel(trainFeatureLabel==trainLabel(i))=i;
        predLabel(predLabel==trainLabel(i))=i;
        actualLabel(actualLabel==trainLabel(i))=i;
        testLabel(testLabel==trainLabel(i))=i;
    end
    %construct the tranMatrix and emisMatrix
    %compute the state transfer number from one state to another
    for i=2:length(trainFeatureLabel)
        tranMatrix(trainFeatureLabel(i-1),trainFeatureLabel(i))=...
            tranMatrix(trainFeatureLabel(i-1),trainFeatureLabel(i))+1;
    end
    for i=1:length(predLabel)
        emisMatrix(actualLabel(i),predLabel(i))=...
            emisMatrix(actualLabel(i),predLabel(i))+1;
    end
    for i=1:stateNumber
        tranMatrix(i,:)=tranMatrix(i,:)/sum(tranMatrix(i,:));
        emisMatrix(i,:) = emisMatrix(i,:)/sum(emisMatrix(i,:));
    end
    % construct the hmm model
    pi = ones(stateNumber)/stateNumber;
    %tranMatrix = ones(6,6)/6;
    %emitMatrix = ones(6,6)/6;
    [probfinal,A,B,pi] = BaumWelch(stateNumber,stateNumber, tranMatrix,emisMatrix,pi,testLabel');
    [prob, y] = viterbi(stateNumber,stateNumber, A,B,pi,testLabel');
    y = trainLabel(y);
end