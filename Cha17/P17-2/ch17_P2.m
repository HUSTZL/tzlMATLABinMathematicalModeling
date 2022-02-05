%% 2012A_question1_T evaluation
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%--------------------------------------------------------------------------
%% ����׼��
% ��ջ�������
clear all
clc

%��������(�����Ѿ�)
% X1=xlsread('2012A_T1_processed.xls', 'T1_white_grape', 'D3:M282');
% X2=xlsread('2012A_T1_processed.xls', 'T2_white_grape', 'D3:M282');
%��������(�����Ѿ�)
X1=xlsread('2012A_T1_processed.xls', 'T1_red_grape', 'D3:M272');
X2=xlsread('2012A_T1_processed.xls', 'T2_red_grape', 'D3:M272');

%% ����ÿ��Ʒ��ʦ��ÿ����Ʒ�ķ���
[m,n]=size(X1);
K=27;
% K=28 �����Ѿ�
% ����ÿ����Ʒ���ܵ÷�
for i=1:K
      for j=1:n
      SX1(i,j)=sum(X1(10*i-9:10*i,j));
      SX2(i,j)=sum(X2(10*i-9:10*i,j));
      end
      u0(i)=mean([SX1(i,:), SX2(i,:)]);
end
% ���㷽��
for i=1:K
    SD1(i,:)=(SX1(i,:)-u0(i)).*(SX1(i,:)-u0(i));
    SD2(i,:)=(SX2(i,:)-u0(i)).*(SX2(i,:)-u0(i));
end

%% �����ʾ��Ƚ�
for i=1:K
    TSD(1,i)=sum(SD1(i,:));
    TSD(2,i)=sum(SD2(i,:));
end
t=1:K;
plot(t,TSD(1,:),'*k-',t,TSD(2,:),'ok--', 'LineWidth', 2)
set(gca,'linewidth',2);
legend('һ�鷽��','���鷽��')
xlabel('�����Ѿ���Ʒ���'); ylabel('�����Ѿ����۷���');
TSD1=sum(TSD(1,:));
TSD2=sum(TSD(2,:));
disp(['һ��԰����Ѿ��ܷ���:' num2str(TSD1)]);
disp(['����԰����Ѿ��ܷ���:' num2str(TSD2)]);



    
    
    



