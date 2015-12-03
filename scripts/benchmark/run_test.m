%% this script classifies and generates the "ward" accuracy measures
% This is the master script
%--------------------------------------------------------------------------
% the structure of the results is:
% the main output is the variable resultmean which is a structure.
%      resultmean.acc is the structure array of accuracy measures
%      resultmean.pred is the structure array of predicted labels
%      resultmean.actCls is the structure array of actual labels
% -------------------------------------------------------------------------
% resultmean.acc  
%   resultmean.acc is a (nSubjects x nClassifiers) array. The row indicates
%   the Subject and the columns indicate the classifier in the order: 
%           LDA, QDA, KNN1, KNN3, NCC
%   Each element is a structure array with 2 elements
%       the first is for various prediction measures for locomotion
%       the second is for various prediction measures for gestures
%
%   The code uses normMact, normMnull and diagavg parts of the element
% -------------------------------------------------------------------------
% resultmean.pred
%   resultmean.pred is a(nSubjects x nClassifiers) array. The row indicates
%   the Subject and the columns indicate the classifier in the order: 
%           LDA, QDA, KNN1, KNN3, NCC
%   Each element is a structure array with 2 elements
%       the first is for various accuracy measures for locomotion
%       the second is for various accuracy measures for gestures
% -------------------------------------------------------------------------        
% resultmean.actCls is a (nSubjects x 1) array with each element being an
% array of the actual class labels
% -------------------------------------------------------------------------
%  The script also generates bar plots of various measures using methods
%  developed by Jamie Ward et al. An excel file is also generated which has
%  the values of the various accuracy measures.
% -------------------------------------------------------------------------
% Excel file
% The columns are Null Activity, Sensitivity, Precision, FP,
%   normMact- weighted avg. of f measures of conf matrix without null class
%   normMnull- weighted avg. of f measures of conf matrix with null class
%   diagavg- sum of diag. of conf matrix/sum of all elements of confmatrix
% The rows are LDA, QDA, KNN1, KNN3, NCC grouped by subjects i.e.
%   row1-row5: Subj1,   row6-row10: Subj2.....
%--------------------------------------------------------------------------
rng('default');
%% Classsification
clear
tic
% %Subject 1
% load UCIbegin1;
% sprintf('subject 1\n')
% param=parameters;
% param.missingValue.colthreshold = 1;
% if strcmp('meanVar',param.FX.method)
%     param.featureReduction.param=110;
% end
% param.classifier='knn';fprintf(param.classifier);
% param.K = 3;
% [resultmean.pred{1,1},resultmean.actCls{1,1},resultmean.acc{1,1}]=tanalyze(training1,test1,1,param);
% save('results.mat','resultmean');
% % 
% % % % subject 2
load UCIbegin2;
sprintf('subject 2\n')
param=parameters;
param.FX.method='meanVar';
param.missingValue.colthreshold = 1;
if strcmp('meanVar',param.FX.method)
    param.featureReduction.param=110;
end
param.classifier='knn';fprintf(param.classifier);
param.K = 2;
[resultmean.pred{2,1},resultmean.actCls{2,1},resultmean.acc{2,1}]=tanalyze(training2,test2,1,param);
save('results.mat','resultmean');
% % 
% % subject 3
% load UCIbegin3;
% sprintf('subject 3\n')
% param=parameters;
% param.FX.method='mean';
% param.missingValue.colthreshold = 1;
% if strcmp('meanVar',param.FX.method)
%     param.featureReduction.param=110;
% end
% param.classifier='knn';fprintf(param.classifier);
% param.K = 4;
% [resultmean.pred{3,1},resultmean.actCls{3,1},resultmean.acc{3,1}]=tanalyze(training3,test3,1,param);
% save('results.mat','resultmean');

%Subject 4
% load UCIbegin4;
% sprintf('subject 4\n')
% param=parameters;
% param.FX.method='meanVar';
% param.missingValue.colthreshold = 1;
% 
% if strcmp('meanVar',param.FX.method)
%     param.featureReduction.param=110;
% end
% param.featureReduction.param = 200;
% param.classifier='knn';fprintf(param.classifier);
% param.K = 1;
% param.missingValue.mode = 'R';
% 
% [resultmean.pred{4,1},resultmean.actCls{4,1},resultmean.acc{4,1}]=tanalyze(training4,test4,1,param);
% save('results.mat','resultmean');