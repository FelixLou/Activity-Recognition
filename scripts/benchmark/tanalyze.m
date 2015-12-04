function [Cllss,testLabel,Accuracy]=tanalyze(training,testing,ngroups,param)
% This function classifies the test data using the training set.
%--------------------------------------------------------------------------
% The inputs are:
%   training: it is the training set with the last columns being the class labels
%   test: it is the test set with the last columns being the actual class labels
%   ngroups: number of different types of classes. For example if ngroups=2,
%           then we are classifying test by two different ways
%   param: the script with all the parameter values
%--------------------------------------------------------------------------
% The outputs are:
%   Cllss: the predicted labels for test
%   testLabel: the actual labels of test
%   Accuracy: A structure of various accuracy measures
% -------------------------------------------------------------------------
% Constraint on the input data (for logical interpretation)
%   no. of columns of test data = no. of columns of training
%%    
if nargin<4
    param=parameters;
end

%sorting the training and test data as per the time stamps
%have been sorted in tarrange in data_proc
    for i = 2:size(training,1)
        if training(i,1) < training(i-1,1)            
            training(i:end,1) = training(i:end,1) - (training(i,1) - training(i-1,1)) + (training(i-1,1) - training(i-2,1));
        end
    end
    for i = 2:size(testing,1)
        if testing(i,1) < testing(i-1,1)            
            testing(i:end,1) = testing(i:end,1) - (testing(i,1) - testing(i-1,1)) + (testing(i-1,1) - testing(i-2,1));
        end
    end
    
% Handle missing values
    [training testing] = missingValueHandler(training,testing,param.missingValue);
    
% Separating various parts of the data 
    szData=size(training);
    szTest=size(testing);
    
    train=training(:,1:szData(2)-ngroups);
% Feature extraction for training data
    trainFeature=featureExtraction(train,param.FX,1);
    trainLabel=training(:,szData(2)-ngroups+1:szData(2));
    
    % Recalculating groups based on FX
    for i=1:1:size(trainLabel,2)
        trainFeatureLabel(:,i)=featureExtraction(trainLabel(:,i),param.FX,2);
    end
    
   
    %% cross validation 
    numTraining=floor(0.7*length(trainFeature));
    trainFeaturePart1 = trainFeature(1:numTraining,:);
    trainFeaturePart2 = trainFeature(1+numTraining:end,:);
    trainLabelPart1 = trainFeatureLabel(1:numTraining,:);
    trainLabelPart2 = trainFeatureLabel(1+numTraining:end,:);
    
    test=testing(:,1:szTest(2)-ngroups);
    % Feature extraction for test data
    testFeature=featureExtraction(test,param.FX,1);
    testLabel=testing(:,szTest(2)-ngroups+1:szTest(2));
    for i=1:1:size(trainLabel,2)
        testFeatureLabel(:,i)=featureExtraction(testLabel(:,i),param.FX,2);        
    end
 %% Classification
    ROC = cell(1,ngroups);
    f = cell(1,ngroups);
    threshold = cell(1,ngroups);
    switch param.classifier
    % knn classifier
       case 'diagquadratic'
            Cls=zeros(size(testFeature,1),ngroups);
            for col=1:1:ngroups
                [threshold{col}, Cls(:,col),f{col},ROC{col}]=classifyAndReject(trainFeature,trainFeatureLabel(:,col),unique(trainLabel(:,col)),...
                    testFeature,testFeatureLabel(:,col),'diagquadratic');
                Accuracy(col).threshold=threshold{col};
                Accuracy(col).threshold_limits=f{col};
                Accuracy(col).ROC = ROC{col};
            end
        case 'knn'
            Cls=zeros(size(testFeature,1),ngroups);
            for col=1:1:ngroups
                Cls(:,col)=knn(testFeature,trainFeature,trainFeatureLabel(:,col),param.K);
                predictLabel=knn(trainFeaturePart2,trainFeaturePart1,trainLabelPart1(:,col),param.K);
                testProbMat=HMM_Train_Viterbi(predictLabel,trainLabelPart2(:,col),trainFeatureLabel,Cls(:,col));
            end
            Cls = testProbMat;     
    end
    trainLabel = unique(trainFeatureLabel);
    stateNumber = length(trainLabel);
%expanding predicted labels to original size
    if strcmp(param.FX.method,'raw')
        Cllss=Cls;
    else
    for i=1:1:size(Cls,2)
        Cllss(:,i)=expandingLabels(Cls(:,i),param.FX.window,size(testLabel,1),param.FX.step);
    end
    end
%% Accuracy
    for i=1:1:ngroups
        [Accuracy(i).F, Accuracy(i).ward]=clsAccuracy(testLabel(:,i),Cllss(:,i),test);
        
    end 
%ROC curve and AUC
    actExpandLabels = repmat(Cllss',6,1);
    for stateth = 1:1:stateNumber
       for i = 1: 1: length(Cllss')
           if trainLabel(stateth) == actExpandLabels(stateth,i)
               actExpandLabels(stateth,i) = 1;
           else
               actExpandLabels(stateth,i) = 0;
           end
       end
    end
    figure;
    hold on;
    for stateth = 1:1:stateNumber
        [X,Y,T,AUC(stateth)] = perfcurve(testLabel',actExpandLabels(stateth,:),trainLabel(stateth));
        %subplot(2,4,stateth+1)
        summer(stateth) = sum(actExpandLabels(stateth,:));
        plot(X,Y)
    end
    weightedAUC = 0;
    for stateth = 1:1:stateNumber
        weightedAUC = summer(stateth)*AUC(stateth)/length(actExpandLabels(stateth,:)) + weightedAUC;
    end
    weightedAUC
    

end