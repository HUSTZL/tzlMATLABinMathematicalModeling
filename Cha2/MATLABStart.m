% MATLAB ���Ű���
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��������
clc, clear, close all
% ��������
[~, ~, raw] = xlsread('sz000004.xls','Sheet1','A2:H99');

% �����������
data = reshape([raw{:}],size(raw));

% ����������������б�������
Date = data(:,1);
DateNum = data(:,2);
Popen = data(:,3);
Phigh = data(:,4);
Plow = data(:,5);
Pclose = data(:,6);
Volum = data(:,7);
Turn = data(:,8);
% �����ʱ����
 clearvars data raw;

 %% ����̽��
figure % ����һ���µ�ͼ�񴰿�
plot(DateNum,Pclose,'k') % ����ͼ�ĵ���ɫ�ĺ�ɫ(��ӡ��ʧ��)
datetick('x','mm');% ����������ʾ����
xlabel('����'); % x��˵��
ylabel('���̼�'); % y��˵��
figure
bar(Pclose) % ��Ϊ����ͼ��

%% ��Ʊ��ֵ������
p = polyfit(DateNum,Pclose,1); % ����ʽ���,
% �ֺ�����Ϊ�����������ʾִ�н��
P1 = polyval(p,DateNum); % �õ�����ʽģ�͵Ľ��
figure
plot(DateNum,P1,DateNum,Pclose,'*g'); % ģ����ԭʼ���ݵĶ���
value = p(1) % ��б�ʸ�ֵ��value�� ��Ϊ��Ʊ�ļ�ֵ��
 
%% ��Ʊ���յ�����
MaxDD = maxdrawdown(Pclose); % �������س�
risk = MaxDD  % �����س���ֵ��risk�� ��Ϊ��Ʊ�ķ���