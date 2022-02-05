%% һԪ�����Իع�ʵ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��������
clc, clear all, close all
x=[1.5, 4.5, 7.5,10.5,13.5,16.5,19.5,22.5,25.5];
y=[7.0,4.8,3.6,3.1,2.7,2.5,2.4,2.3,2.2];  
plot(x,y,'*','linewidth',2);
set(gca,'linewidth',2);
xlabel('���۶�x/��Ԫ','fontsize', 12)           
ylabel('��ͨ����y/%', 'fontsize',12)           

%% ������ʽ
m1 = @(b,x) b(1) + b(2)*log(x);
nonlinfit1 = fitnlm(x,y,m1,[0.01;0.01])
b=nonlinfit1.Coefficients.Estimate;
Y1=b(1,1)+b(2,1)*log(x);
hold on
plot(x,Y1,'--k','linewidth',2)

%% ָ����ʽ���
m2 = 'y ~ b1*x^b2';
nonlinfit2 = fitnlm(x,y,m2,[1;1])
b1=nonlinfit2.Coefficients.Estimate(1,1);
b2=nonlinfit2.Coefficients.Estimate(2,1);
Y2=b1*x.^b2;
hold on
plot(x,Y2,'r','linewidth',2)
legend('ԭʼ����','a+b*lnx','a*x^b')
