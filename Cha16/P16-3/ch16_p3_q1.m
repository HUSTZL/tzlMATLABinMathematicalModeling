%% ���·������⣬�Լ����еĽ�Ѳ������ƽ̨���÷����ĺ����Ե��ж�
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc; clear all; close all
%% ����׼��
% ȫ�н�ͨ������·�ڽڵ�ڵ�����
A=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڽڵ�����','A2:C583'); 
% ȫ�н�ͨ·��
B=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڵ�·��','A2:B929');
% ÿ��·�ڷ�����(����)
owl=xlsread('2011B_Table.xls', 'ȫ�н�ͨ·�ڽڵ�����','E2:E93');
%% ������̾������
arn=size(A,1)
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
    apsn=4;
    com_pat=nchoosek(alt_sta,apsn);
    com_num=size(com_pat, 1);
    avn=0;
    bfair_f=inf;
    for k1=1:com_num
         npsl=[ppsl, com_pat(k1,:)]; % ���¾�̨���÷���
        % ���㻹�ж���·�ڲ�����3���ӳ��� 
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
         
         if tun_num==0
          avn=avn+1;
          workload=zeros(1, 24);
               for j=1:24
                 for u=1:92
                     if SR(u,2)==npsl(1,j)
                     workload(1,j)=workload(1,j)+owl(u,1);
                     end
                  end
               end
               fair_f=var(workload,1);
               fair_r(avn,:)=[avn, fair_f,  com_pat(k1,:)];             
               
              if fair_f<bfair_f
                   bfair_f=fair_f;
                   ba=com_pat(k1,:);
                   bs=SR;
              end
         end       
    end      
%% �رն�˼���
if matlabpool('size') > 0
    matlabpool close
end
%% ��ʾ���
abpn=0;
for i=1:avn
    if fair_r(i,2)==bfair_f
        abpn=abpn+1;
        abps(abpn,:)=[abpn, fair_r(i,2:end)];
    end
end
disp(['���п��з�����' num2str(avn)]);
disp(['��ѷ�����' num2str(abpn)]);
disp('������ѷ���:')
abps
disp('��ѷ�����Ӧ�Ĺ��������:')
bfair_f
plot(fair_r(:,1),fair_r(:,2),'-ko', 'LineWidth', 2);
set(gca,'linewidth',2) ;
xlabel('���з������'); ylabel('���������');
title('�����з����Ĺ��������','fontsize',12);       



