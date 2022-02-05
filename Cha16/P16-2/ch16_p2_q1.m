%% ���·������⣬�Լ����еĽ�Ѳ������ƽ̨���÷����ĺ����Ե��ж�
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc; clear all; close all
%% ����׼��
% ȫ�н�ͨ������·�ڽڵ�ڵ�����
A=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڽڵ�����','A2:C583'); 
% ȫ�н�ͨ·��
B=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڵ�·��','A2:B929');
% A��Ѳ��̨����λ��
%PS_A=xlsread('2011B_Table.xls', 'ȫ�н�Ѳ��ƽ̨','B2:B21');

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

%% ȷ�����������̨��
alt_sta=21:92;
ppsl=1:20;
min_n=ones(1,5)*6;
%% ����˫�˼��ټ���(��˼�����ſ��Բ���)
if matlabpool('size') == 0 
    matlabpool open 2
end
%% �����������̨�����Ӧ�Ĳ�����3���ӳ�����·����
for apsn=2:5
    com_pat=nchoosek(alt_sta,apsn);
    com_num=size(com_pat, 1);
    tmin_un_num=6;
    for k1=1:com_num
         npsl=[ppsl, com_pat(k1,:)]; % ���¾�̨���÷���
        %% ���㻹�ж���·�ڲ�����3���ӳ��� 
         SR=zeros(92,4);
         for i=1:92
             i;
         SR(i,1)=i;
         SR(i,2)=0;
         SR(i,3)=inf;
         SR(i,4)=0;
                for j=1:(20+apsn)
                   if SR(i,3)>dmin(i,npsl(j))
                      SR(i,3)=dmin(i,npsl(j));
                      SR(i,2)=npsl(j);
                   end
                end
                if SR(i,3)*100>3000
                   SR(i,4)=1;
                end    
         end
         tun_num=sum(SR(:,4));
         if tun_num<tmin_un_num
            tmin_un_num=tun_num;
         end
         if tmin_un_num==0
             break
         end
         
    end
    min_n(1,apsn)=tmin_un_num;
end
     
%% �رն�˼���
if matlabpool('size') > 0
    matlabpool close
end
%% ��ʾ���
apn=[0, 2, 3, 4, 5]';
f_result=[apn, min_n']
figure(1) 
bar(apn,min_n)
xlabel('��������ƽ̨������');
ylabel('������3���ӳ�����·����');
title('�����������ӳ�����·��������������̨���Ĺ�ϵͼ','fontsize',12);
for i=1:4
    FT(1,i)=i+2*min_n(1,i+1);
end
opn=find(FT==min(FT));
disp(['�����������ƽ̨��:' num2str(opn+1)]);
T=2:5;
figure(2)
plot(T, FT,'-ko', 'LineWidth', 2);
xlabel('��������ƽ̨������');
ylabel('Ŀ�꺯��');
title('Ŀ�꺯������������ƽ̨������ϵͼ','fontsize',12);





        



