%% һԪ���Իع�ʵ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��������
clc, clear all, close all
x=[23.80,27.60,31.60,32.40,33.70,34.90,43.20,52.80,63.80,73.40];
y=[41.4,51.8,61.70,67.90,68.70,77.50,95.90,137.40,155.0,175.0];	
%% ������С���˻ع�
% ����ɢ��ͼ���ж��Ƿ�������Թ�ϵ
figure
plot(x,y,'r*')                         %��ɢ��ͼ
xlabel('x��ְ�������ܶ','fontsize', 12)           %��������
ylabel('y����Ʒ�����ܶ', 'fontsize',12)           %��������
set(gca,'linewidth',2);
% ������С�������
Lxx=sum((x-mean(x)).^2);
Lxy=sum((x-mean(x)).*(y-mean(y)));
b1=Lxy/Lxx;
b0=mean(y)-b1*mean(x);
y1=b1*x+b0;
hold on
plot(x, y1,'linewidth',2);

%% ����LinearModel.fit�������лع�
m2 = LinearModel.fit(x,y)

%% ����regress�������лع�
Y=y';
X=[ones(size(x,2),1),x'];
[b, bint, r, rint, s] = regress(Y, X)