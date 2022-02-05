%% ���෽��ʾ������
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc, clear all, close all
%% �������ݼ�����Ԥ���� 
load bank.mat
% ���������ת���ɷ�������
names = bank.Properties.VariableNames;
category = varfun(@iscellstr, bank, 'Output', 'uniform');
for i = find(category)
    bank.(names{i}) = categorical(bank.(names{i}));
end
% ���ٷ������
catPred = category(1:end-1);
% ����Ĭ����������ɷ�ʽȷ���ýű��еĽ���ǿ������ֵ�
rng('default');
% ����̽��----���ݿ��ӻ�
figure(1)
gscatter(bank.balance,bank.duration,bank.y,'kk','xo')
xlabel('��ƽ�����/��Ԫ', 'fontsize',12)
ylabel('�ϴνӴ�ʱ��/��', 'fontsize',12)
title('���ݿ��ӻ�Ч��ͼ', 'fontsize',12)
set(gca,'linewidth',2);

% ������Ӧ������Ԥ�����
X = table2array(varfun(@double, bank(:,1:end-1)));  % Ԥ�����
Y = bank.y;   % ��Ӧ����
disp('������Yes & No��ͳ�ƽ����')
tabulate(Y)
%�����������һ��ת���ɶ����������Ա���ĳЩ�㷨�Է�������Ĵ���
XNum = [X(:,~catPred) dummyvar(X(:,catPred))];
YNum = double(Y)-1;

%% ���ý�����֤��ʽ
% ���ѡ��40%��������Ϊ��������
cv = cvpartition(height(bank),'holdout',0.40);
% ѵ����
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv),:);
XtrainNum = XNum(training(cv),:);
YtrainNum = YNum(training(cv),:);
% ���Լ�
Xtest = X(test(cv),:);
Ytest = Y(test(cv),:);
XtestNum = XNum(test(cv),:);
YtestNum = YNum(test(cv),:);
disp('ѵ������')
tabulate(Ytrain)
disp('���Լ���')
tabulate(Ytest)

%% �����
% ѵ��������
knn = ClassificationKNN.fit(Xtrain,Ytrain,'Distance','seuclidean',...
                            'NumNeighbors',5);
% ����Ԥ��
[Y_knn, Yscore_knn] = knn.predict(Xtest);
Yscore_knn = Yscore_knn(:,2);
% �����������
disp('����ڷ�����������')
C_knn = confusionmat(Ytest,Y_knn)

%% ��Ҷ˹
% ���÷ֲ�����
dist = repmat({'normal'},1,width(bank)-1);
dist(catPred) = {'mvmn'};
% ѵ��������
Nb = NaiveBayes.fit(Xtrain,Ytrain,'Distribution',dist);
% ����Ԥ��
Y_Nb = Nb.predict(Xtest);
Yscore_Nb = Nb.posterior(Xtest);
Yscore_Nb = Yscore_Nb(:,2);
% �����������
disp('��Ҷ˹������������')
C_nb = confusionmat(Ytest,Y_Nb)

%% ������
% ����������ģʽ������
hiddenLayerSize = 5;
net = patternnet(hiddenLayerSize);
% ����ѵ��������֤���Ͳ��Լ�
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
% ѵ������
net.trainParam.showWindow = false;
inputs = XtrainNum';
targets = YtrainNum';
[net,~] = train(net,inputs,targets);
% �ò��Լ����ݽ���Ԥ��
Yscore_nn = net(XtestNum')';
Y_nn = round(Yscore_nn);
% �����������
disp('�����緽����������')
C_nn = confusionmat(YtestNum,Y_nn)

%% Logistic
% ѵ��������
glm = fitglm(Xtrain,YtrainNum,'linear', 'Distribution','binomial',...
    'link','logit','CategoricalVars',catPred, 'VarNames', names);
% �ò��Լ����ݽ���Ԥ��
Yscore_glm = glm.predict(Xtest);
Y_glm = round(Yscore_glm);
% �����������
disp('Logistic������������')
C_glm = confusionmat(YtestNum,Y_glm)

%% �б����
% ѵ��������
da = ClassificationDiscriminant.fit(XtrainNum,Ytrain);
% ����Ԥ��
[Y_da, Yscore_da] = da.predict(XtestNum); 
Yscore_da = Yscore_da(:,2);
% �����������
disp('�б𷽷���������')
C_da = confusionmat(Ytest,Y_da)

%% ֧��������(SVM)
% ��������������
opts = statset('MaxIter',45000);
% ѵ��������
svmStruct = svmtrain(Xtrain,Ytrain,'kernel_function','linear','kktviolationlevel',0.2,'options',opts);
% ����Ԥ��
Y_svm = svmclassify(svmStruct,Xtest);
Yscore_svm = svmscore(svmStruct, Xtest);
Yscore_svm = (Yscore_svm - min(Yscore_svm))/range(Yscore_svm);
% �����������
disp('SVM������������')
C_svm = confusionmat(Ytest,Y_svm)

%% ������
% ѵ��������
t = ClassificationTree.fit(Xtrain,Ytrain,'CategoricalPredictors',catPred);
% ����Ԥ��
Y_t = t.predict(Xtest);
% �����������
disp('������������������')
C_t = confusionmat(Ytest,Y_t)

%% ͨ��ROC�������ȽϷ���
methods = {'KNN','NBayes','NNet', 'GLM',  'LDA', 'SVM'};
scores = [Yscore_knn, Yscore_Nb, Yscore_nn, Yscore_glm, Yscore_da,  Yscore_svm];
%����ROC����
figure
auc= zeros(6); hCurve = zeros(1,6);
for ii=1:6;
  [rocx, rocy, ~, auc(ii)] = perfcurve(Ytest, scores(:,ii), 'yes');
  hCurve(ii,:) = plot(rocx, rocy, 'k','LineWidth',2); hold on;
end
legend(hCurve(:,1), methods)
set(gca,'linewidth',2);
grid on;
title('������ROC����', 'fontsize',12); 
xlabel('������ [ = FP/(TN+FP)]', 'fontsize',12); 
ylabel('������ [ = TP/(TP+FN)]', 'fontsize',12);
% ���Ƹ�����������ȷ��
figure;
bar(auc); set(gca,'YGrid', 'on','XTickLabel',methods); 
xlabel('�������', 'fontsize',12); 
ylabel('������ȷ��', 'fontsize',12);
title('������������ȷ��','fontsize',12);
set(gca,'linewidth',2);
 