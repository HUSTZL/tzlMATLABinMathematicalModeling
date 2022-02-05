% ���ݿ��ӻ��������ݷֲ���״ͼ
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
% ��ȡ����
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
dv1=X(:,2);

% ���Ʊ���dv1����״�ֲ�ͼ
h = -5:0.5:5;
n = hist(dv1,h);
figure
bar(h, n)

% ���㳣�õ���״����ָ��
mn = mean(dv1); % ��ֵ
sdev = std(dv1); % ��׼��
mdsprd = iqr(dv1); % �ķ�λ��
mnad = mad(dv1); % ��λ��
rng = range(dv1); % ����

% ��ʶ������ֵ
x = round(quantile(dv1,[0.25,0.5,0.75]));
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','x','color','r')

x = round(mn + sdev*[-1,0,1]);
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','o','color',[0 0.5 0])

x = round(mn + mnad*[-1,0,1]);
y = (n(h==x(1)) + n(h==x(3)))/2;
line(x,[y,y,y],'marker','*','color',[0.75 0 0.75])

x = round([min(dv1),max(dv1)]);
line(x,[1,1],'marker','.','color',[0 0.75 0.75])

legend('Data','Midspread','Std Dev','Mean Abs Dev','Range')
