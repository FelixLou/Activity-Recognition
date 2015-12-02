load results
%% Arranging the data and plotting accuracies
nSubj=size(resultmean.acc,1);
nClassifiers=size(resultmean.acc,2);

label={'t1DL', 't1DQ', 't1KNN1', 't1KNN3', 't1NCC';'t2DL', 't2DQ', 't2KNN1', 't2KNN3', 't2NCC';'tDL', 't3DQ', 't3KNN1', 't3KNN3', 't3NCC';'t4DL', 't4DQ', 't4KNN1', 't4KNN3', 't4NCC'};
data1=[];
data2=data1;
for iSubj=1:nSubj
    for jClass=1:nClassifiers
        data1{iSubj,jClass} = resultmean.acc{iSubj,jClass}(1,1).ward.t;
        %data2{iSubj,jClass} = resultmean.acc{iSubj,jClass}(1,2).ward.t;
    end
end

%%
% [data1 label1]=resultsArrange(4,5,'t1DL',AccuracyDLmean1(1).ward.t,'t1DQ',AccuracyDQmean1(1).ward.t,'t1KNN1',AccuracyKNN1mean1(1).ward.t,'t1KNN3',AccuracyKNN3mean1(1).ward.t,'t1NCC',AccuracyNCCmean1(1).ward.t,'t2DL',AccuracyDLmean2(1).ward.t,'t2DQ',AccuracyDQmean2(1).ward.t,'t2KNN1',AccuracyKNN1mean2(1).ward.t,'t2KNN3',AccuracyKNN3mean2(1).ward.t,'t2NCC',AccuracyNCCmean2(1).ward.t,'t3DL',AccuracyDLmean3(1).ward.t,'t3DQ',AccuracyDQmean3(1).ward.t,'t3KNN1',AccuracyKNN1mean3(1).ward.t,'t3KNN3',AccuracyKNN3mean3(1).ward.t,'t3NCC',AccuracyNCCmean3(1).ward.t,'t4DL',AccuracyDLmean4(1).ward.t,'t4DQ',AccuracyDQmean4(1).ward.t,'t4KNN1',AccuracyKNN1mean4(1).ward.t,'t4KNN3',AccuracyKNN3mean4(1).ward.t,'t4NCC',AccuracyNCCmean4(1).ward.t);
% [data2 label2]=resultsArrange(4,5,'t1DL',AccuracyDLmean1(2).ward.t,'t1DQ',AccuracyDQmean1(2).ward.t,'t1KNN1',AccuracyKNN1mean1(2).ward.t,'t1KNN3',AccuracyKNN3mean1(2).ward.t,'t1NCC',AccuracyNCCmean1(2).ward.t,'t2DL',AccuracyDLmean2(2).ward.t,'t2DQ',AccuracyDQmean2(2).ward.t,'t2KNN1',AccuracyKNN1mean2(2).ward.t,'t2KNN3',AccuracyKNN3mean2(2).ward.t,'t2NCC',AccuracyNCCmean2(2).ward.t,'t3DL',AccuracyDLmean3(2).ward.t,'t3DQ',AccuracyDQmean3(2).ward.t,'t3KNN1',AccuracyKNN1mean3(2).ward.t,'t3KNN3',AccuracyKNN3mean3(2).ward.t,'t3NCC',AccuracyNCCmean3(2).ward.t,'t4DL',AccuracyDLmean4(2).ward.t,'t4DQ',AccuracyDQmean4(2).ward.t,'t4KNN1',AccuracyKNN1mean4(2).ward.t,'t4KNN3',AccuracyKNN3mean4(2).ward.t,'t4NCC',AccuracyNCCmean4(2).ward.t);
[handle1,measuresLoco]=wardbars(label,data1);
title('Locomotion','FontWeight','bold','FontSize',12);
%[handle2,measuresGest]=wardbars(label,data2);
%title('Gestures','FontWeight','bold','FontSize',12);
save('measuresLocoII.mat','measuresLoco');
%save('measuresGestII.mat','measuresGest');
%% Exporting various measures to xls file
% Change the file location and name to avoid overwrite
matloco=res2mat(measuresLoco,resultmean.acc,'loco');
%matgest=res2mat(measuresGest,resultmean.acc,'gest');
xlswrite('benchmark.xls',matloco,'Sheet1','C3');
%xlswrite('benchmark.xls',matgest,'Sheet2','C3');
toc