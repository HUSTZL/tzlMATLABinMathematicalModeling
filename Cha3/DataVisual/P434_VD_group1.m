% ���ݿ��ӻ��������ݷ���
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
% ��ȡ����
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
dv1=X(:,2);
eva=X(:,12);
% Boxplot
figure
boxplot(X(:,2:12))
figure
boxplot(dv1, eva)
figure
boxplot(X(:,5))
