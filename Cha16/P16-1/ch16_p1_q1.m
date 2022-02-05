%% ���·������⣬�Լ����еĽ�Ѳ������ƽ̨���÷����ĺ����Ե��ж�
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc; clear all;
%% ����׼��
% ȫ�н�ͨ������·�ڽڵ�ڵ�����
A=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڽڵ�����','A2:C583'); 
% ȫ�н�ͨ·��
B=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڵ�·��','A2:B929');
% A��Ѳ��̨����λ��
PS_A=xlsread('2011B_Table.xls', 'ȫ�н�Ѳ��ƽ̨','B2:B21');

%% ������̾������
arn=size(A,1);
brn=size(B,1);
% �����������
D=ones(arn);
D(:)=inf;
for i=1:arn
    D(i,i)=0;
end

for i=1:brn
    m=B(i,1);   % �����
    n=B(i,2);   % �յ���
    d=sqrt((A(m,2)-A(n,2))^2+(A(m,3)-A(n,3))^2);
    D(m,n)=d;
    D(n,m)=d;
end
[dmin,path]=floyd(D);

%% ����A����Ѳ������ƽ̨��Ͻ��Χ
PN_A=A(1:92,1);
psn=size(PS_A, 1);
for i=1:92
    SR(i,1)=i;
    SR(i,2)=0;
    SR(i,3)=inf;
    SR(i,4)=0;
    for j=1:psn
        if SR(i,3)>dmin(i,j)
         SR(i,3)=dmin(i,j);
         SR(i,2)=j;
        end
    end
    if SR(i,3)*100>3000
       SR(i,4)=1;
    end    
end
%% ������ 
disp('A����Ѳ������ƽ̨��Ͻ��Χ���ַ���Ϊ��')
SR

        



