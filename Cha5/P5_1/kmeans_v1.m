%% K-means������MATLABʵ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ����׼���ͳ�ʼ��
clc
clear
x=[0 0;1 0; 0 1; 1 1;2 1;1 2; 2 2;3 2; 6 6; 7 6; 8 6; 6 7; 7 7; 8 7; 9 7 ; 7 8; 8 8; 9 8; 8 9 ; 9 9];
z=zeros(2,2);
z1=zeros(2,2);
z=x(1:2, 1:2);
%% Ѱ�Ҿ�������
while 1
    count=zeros(2,1);
    allsum=zeros(2,2);
    for i=1:20 % ��ÿһ������i�����㵽2���������ĵľ���
        temp1=sqrt((z(1,1)-x(i,1)).^2+(z(1,2)-x(i,2)).^2);
        temp2=sqrt((z(2,1)-x(i,1)).^2+(z(2,2)-x(i,2)).^2);
        if(temp1<temp2)
            count(1)=count(1)+1;
            allsum(1,1)=allsum(1,1)+x(i,1);
            allsum(1,2)=allsum(1,2)+x(i,2);
        else
            count(2)=count(2)+1;
            allsum(2,1)=allsum(2,1)+x(i,1);
            allsum(2,2)=allsum(2,2)+x(i,2); 
        end
    end
    z1(1,1)=allsum(1,1)/count(1);
    z1(1,2)=allsum(1,2)/count(1);
    z1(2,1)=allsum(2,1)/count(2);
    z1(2,2)=allsum(2,2)/count(2);
    if(z==z1)
        break;
    else
        z=z1;
    end
end
%% �����ʾ
disp(z1);% �����������
plot( x(:,1), x(:,2),'k*',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.5,0.5,0.5])
hold on
plot(z1(:,1),z1(:,2),'ko',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.5,0.5,0.5])
set(gca,'linewidth',2) ;
xlabel('����x1','fontsize',12);
ylabel('����x2', 'fontsize',12);
title('K-means����ͼ','fontsize',12);

