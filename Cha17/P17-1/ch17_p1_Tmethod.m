%% 2012A_question1_T evaluation
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%--------------------------------------------------------------------------
%% ����׼��
% ��ջ�������
clear all
clc

%��������
X1=xlsread('2012A_T1_processed.xls', 'T1_red_grape', 'D3:M272');  
X2=xlsread('2012A_T1_processed.xls', 'T2_red_grape', 'D3:M272');
X3=xlsread('2012A_T1_processed.xls', 'T1_white_grape', 'D3:M282');
X4=xlsread('2012A_T1_processed.xls', 'T2_white_grape', 'D3:M282');

%% �����Ѿ�T����������
[m1,n1]=size(X1);
K1=27; 
% ����ÿ����Ʒ���ܵ÷�
for i=1:K1
      for j=1:n1
      SX1(i,j)=sum(X1(10*i-9:10*i,j));
      SX2(i,j)=sum(X2(10*i-9:10*i,j));
      end
end
% ����ÿ����Ʒ�÷ֵľ�ֵ
for i=1:K1
    Mean1(i)=mean(SX1(i,:));
    Mean2(i)=mean(SX2(i,:));
end
% �������ֵ
for i=1:K1
    S1(1,i)=(sum((SX1(i,:)-Mean1(i)).^2)+sum((SX2(i,:)-Mean2(i)).^2))/(n1*(n1-1));
    T1(1,i)=(Mean1(i)-Mean2(i))/(sqrt(S1(1,i)));
end
AT_R=abs(T1);  
M_AT_R=mean(AT_R);
%% �����Ѿ�T����������
[m2,n2]=size(X3);
K2=28;
% ����ÿ����Ʒ���ܵ÷�
for i=1:K2
      for j=1:n2
      SX3(i,j)=sum(X3(10*i-9:10*i,j));
      SX4(i,j)=sum(X4(10*i-9:10*i,j));
      end
end
% ����ÿ����Ʒ�÷ֵľ�ֵ
for i=1:K2
    Mean3(i)=mean(SX3(i,:));
    Mean4(i)=mean(SX4(i,:));
end
% �������ֵ
for i=1:K2
    S2(1,i)=(sum((SX3(i,:)-Mean3(i)).^2)+sum((SX4(i,:)-Mean4(i)).^2))/(n2*(n2-1));
    T2(1,i)=(Mean3(i)-Mean4(i))/(sqrt(S2(1,i)));
end
AT_W=abs(T2);  
M_AT_W=mean(AT_W);
%% �����ʾ��Ƚ�
a=2.102; % T(0.05,2,18)=2.101
b=2.878; % T(0.01,2,18)=2.878
set(gca,'linewidth',2) 
% ��ƽ��
for i=1:K1
    Ta1(i)=a;
    Tb1(i)=b;
end
t1=1:K1;
subplot(2,1,1);
plot(t1,AT_R,'*k-',t1,Ta1,'r-',t1,Tb1,'-.b', 'LineWidth', 2)
title('��������Լ�����','fontsize',14)
legend('T����ֵ', 'T(0.05)ֵ', 'T(0.01)ֵ')
xlabel('��Ʒ��'), ylabel('T����ֵ')

% �׾ƽ��
for i=1:K2
    Ta2(i)=a;
    Tb2(i)=b;
end
t2=1:K2;
subplot(2,1,2);
plot(t2,AT_W,'*k-',t2,Ta2,'r-',t2,Tb2,'-.b', 'LineWidth', 2)
title('�׾������Լ�����','fontsize',14)
legend('T����ֵ', 'T(0.05)ֵ', 'T(0.01)ֵ')
xlabel('��Ʒ��'), ylabel('T����ֵ')
% ��ʾƽ��������
disp(['����Ʒ��ʦ�Ժ�Ƶ�ƽ��������T����ֵ:' num2str(M_AT_R)]);
disp(['����Ʒ��ʦ�԰׾Ƶ�ƽ��������T����ֵ:' num2str(M_AT_W)]);

    
    
    



