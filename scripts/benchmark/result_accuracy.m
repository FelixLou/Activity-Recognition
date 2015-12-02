dinct = (resultmean.pred{1,1} == resultmean.actCls{1,1});
total = length(test1);
accuracy = sum(dinct)/total

