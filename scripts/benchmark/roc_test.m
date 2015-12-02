% load simplecluster_dataset
% net = patternnet(20);
% net = train(net,simpleclusterInputs,simpleclusterTargets);
% simpleclusterOutputs = sim(net,simpleclusterInputs);
% 
% plotroc(simpleclusterTargets,simpleclusterOutputs)
load fisheriris
pred = meas(51:end,1:2);
resp = (1:100)'>50;  % Versicolor = 0, virginica = 1
mdl = fitglm(pred,resp,'Distribution','binomial','Link','logit');
scores = mdl.Fitted.Probability;
[X,Y,T,AUC] = perfcurve(species(51:end,:),scores,'virginica');
AUC
plot(X,Y)