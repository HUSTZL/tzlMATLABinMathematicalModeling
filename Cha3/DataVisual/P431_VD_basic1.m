% ���ݿ��ӻ�����������ͼ
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
% ��ȡ����
clc, clear al, close all
X=xlsread('dataTableA2.xlsx');
% ���Ʊ���dv1�Ļ����ֲ�
N=size(X,1);
id=1:N;
figure
plot( id, X(:,2),'LineWidth',1)
set(gca,'linewidth',2);
xlabel('���','FontSize',12);
ylabel('dv1', 'fontsize',12);
title('����dv1�ֲ�ͼ','fontsize',12);
% ͬʱ���Ʊ���dv1-dv4����״�ֲ�ͼ
figure
subplot(2,2,1);
hist(X(:,2));
title('dv1��״�ֲ�ͼ','fontsize',12)
subplot(2,2,2);
hist(X(:,3));
title('dv2��״�ֲ�ͼ','fontsize',12)
subplot(2,2,3);
hist(X(:,4));
title('dv3��״�ֲ�ͼ','fontsize',12)
subplot(2,2,4);
hist(X(:,5));
title('dv4��״�ֲ�ͼ','fontsize',12)
