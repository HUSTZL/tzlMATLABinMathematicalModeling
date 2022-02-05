%% ������ѡ��ģ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��������
clc, clear all, close all
s = dataset('xlsfile', 'SampleA1.xlsx');

%% ��Ԫ���Իع�
myFit = LinearModel.fit(s);
disp(myFit) 
sx=s(:,1:10);
sy=s(:,11);
n=1:size(s,1);
sy1= predict(myFit,sx);
figure
plot(n,sy, 'ob', n, sy1,'*r')
xlabel('�������', 'fontsize',12)
ylabel('�ۺϵ÷�', 'fontsize',12)
title('��Ԫ���Իع�ģ��', 'fontsize',12)
set(gca, 'linewidth',2)

%% �𲽻ع�
myFit2 = LinearModel.stepwise(s);
disp(myFit2)
sy2= predict(myFit2,sx);
figure
plot(n,sy, 'ob', n, sy2,'*r')
xlabel('�������', 'fontsize',12)
ylabel('�ۺϵ÷�', 'fontsize',12)
title('�𲽻ع�ģ��', 'fontsize',12)
set(gca, 'linewidth',2)