% ���ݿ��ӻ����������������
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
% ��ȡ����
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
Vars = X(:,7:12);
%  ���Ʊ���������Թ���ͼ
figure
plotmatrix(Vars)
%  ���Ʊ����������ǿ��ͼ
covmat = corrcoef(Vars);
figure
imagesc(covmat);
grid;
colorbar;