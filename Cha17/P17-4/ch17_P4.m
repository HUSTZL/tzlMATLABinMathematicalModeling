%% PCA-kmeans����ʵ�ֶ����ѵ���ָ����о���
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ���ݵ��뼰����
clc, clear all, close all
%  A=xlsread('2012A_Table2.xls','���Ѿ�ָ�����', 'C3:J29');% �����Ѿ�
A=xlsread('2012A_Table2.xls','���Ѿ�ָ�����', 'C33:J60');% �����Ѿ�

%  ���ݱ�׼������
a=size(A,1);  
b=size(A,2);  
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i)); 
end

%% �������ϵ�����������ֵ����������
CM=corrcoef(SA);  % �������ϵ������(correlation matrix)
[V, D]=eig(CM);  % ��������ֵ����������

for j=1:b
    DS(j,1)=D(b+1-j, b+1-j); % ������ֵ�������������
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1)); %������
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1)); %�ۻ�������
end

%% ѡ�����ɷּ���Ӧ����������
T=0.8;  % ���ɷ���Ϣ������.
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end

% ��ȡ���ɷֶ�Ӧ����������
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

%%  ��������۶�������ɷֵ÷�
new_score=SA*PV;
for i=1:a
    total_score(i,1)=sum(new_score(i,:));
    total_score(i,2)=i;
end
result_report=[new_score, total_score]; % �������ɷֵ÷����ַܷ���ͬһ��������
result_report=sortrows(result_report,(K+2)); % ���ֽܷ�������

%% Kmeans���༰�������
A=result_report(:,(K+1));
[idx,ctr]=kmeans(A,4);
[m,n]=size(A);
t1=ones(1,n)*30;
c1=find(idx==1); c2=find(idx==2); c3=find(idx==3); c4=find(idx==4);
h=plot(t1,A,'ko',c1,A(idx==1),'k--*', c2,A(idx==2),'k--s', c3,A(idx==3),'k--d', c4,A(idx==4),'k--p');
xlabel('�����Ѿ���Ʒ���','fontsize',12);
ylabel('���ɷֵ÷�','fontsize',12);
title('�����Ѿ���ָ�����ͼ','fontsize',12)
set(h, 'MarkerSize',8, 'MarkerFaceColor','k');
set(gca,'linewidth',2) ;

disp('���ɷֵ÷�(���1��Ϊ������ţ�������2��Ϊ�ܷ֣�ǰ��Ϊ�����ɷֵ÷�)')
result_report  
disp('��������');
disp(['��1��:' ,'���ĵ㣺',num2str(ctr(1)),'  ','������Ʒ��ţ�', num2str(c1')]);
disp(['��2��:' ,'���ĵ㣺',num2str(ctr(2)),'  ','������Ʒ��ţ�', num2str(c2')]);
disp(['��3��:' ,'���ĵ㣺',num2str(ctr(3)),'  ','������Ʒ��ţ�', num2str(c3')]);
disp(['��4��:' ,'���ĵ㣺',num2str(ctr(4)),'  ','������Ʒ��ţ�', num2str(c4')]);
