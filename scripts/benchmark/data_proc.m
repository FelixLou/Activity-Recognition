clear;

base='../../dataset/';
% % Subject 1
% % training
% sadl1 = load([base 'S1-ADL1.dat']);
% sadl2 = load([base 'S1-ADL2.dat']);
% sadl3 = load([base 'S1-ADL3.dat']);
% % test
% sadl4 = load([base 'S1-ADL4.dat']);
% sadl5 = load([base 'S1-ADL5.dat']);
% 
% [training1,test1]=tarrange(3,sadl1,sadl2,sadl3,sadl4,sadl5);
% selectedCol = [1:37 245];
% training1 = training1(:,selectedCol);
% test1 = test1(:,selectedCol);
% %save('D:\work\matlab\benchmark\tejaswi (copy)\subject1\UCIbegin1.mat','training1','test1');
% save('UCIbegin1.mat','training1','test1');

sadl1 = load([base 'S1-ADL1.dat']);
sadl2 = load([base 'S1-ADL2.dat']);
sadl3 = load([base 'S1-ADL3.dat']);
% test
sadl4 = load([base 'S1-ADL4.dat']);
sadl5 = load([base 'S1-ADL5.dat']);

[training1,test1]=tarrange(3,sadl1,sadl2,sadl3,sadl4,sadl5);
selectedCol = [1:37 245];
training1 = training1(:,selectedCol);
test1 = test1(:,selectedCol);
%save('D:\work\matlab\benchmark\tejaswi (copy)\subject1\UCIbegin1.mat','training1','test1');
save('UCIbegin1.mat','training1','test1');
% clear training1;
% clear test1;