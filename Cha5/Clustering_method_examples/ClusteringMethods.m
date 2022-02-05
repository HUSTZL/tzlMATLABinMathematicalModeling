%% ���෽��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% �������ݺ�Ԥ��������
clc, clear all, close all
load BondData
settle = floor(date);
%����Ԥ����
bondData.MaturityN = datenum(bondData.Maturity, 'dd-mmm-yyyy');
bondData.SettleN = settle * ones(height(bondData),1);
% ɸѡ����
corp = bondData(bondData.MaturityN > settle & ...
             bondData.Type == 'Corp' & ...
             bondData.Rating >= 'CC' & ...
             bondData.YTM < 30 & ...
             bondData.YTM >= 0, :);
% ������������ɷ�ʽ��֤���������
rng('default');

%% ̽������
% ���ݿ��ӻ�
figure
gscatter(corp.Coupon,corp.YTM,corp.Rating)
set(gca,'linewidth',2);
xlabel('Ʊ������')
ylabel('����������')

% ѡ��������
corp.RatingNum = double(corp.Rating);
bonds = corp{:,{'Coupon','YTM','CurrentYield','RatingNum'}};

% �����������
numClust = 3;

% �������ڿ��ӻ�����Ч���ı���
VX=[corp.Coupon, double(corp.Rating), corp.YTM];

%% K-Means ����
dist_k = 'cosine';
kidx = kmeans(bonds, numClust, 'distance', dist_k);

%���ƾ���Ч��ͼ
figure
F1 = plot3(VX(kidx==1,1), VX(kidx==1,2),VX(kidx==1,3),'r*', ...
           VX(kidx==2,1), VX(kidx==2,2),VX(kidx==2,3), 'bo', ...
           VX(kidx==3,1), VX(kidx==3,2),VX(kidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on;
set(F1,'linewidth',2, 'MarkerSize',8);
xlabel('Ʊ������','fontsize',12);
ylabel('�����÷�','fontsize',12);
ylabel('����������','fontsize',12);
title('Kmeans����������')

% ������������س̶�
dist_metric_k = pdist(bonds,dist_k);
dd_k = squareform(dist_metric_k);
[~,idx] = sort(kidx);
dd_k = dd_k(idx,idx);
figure
imagesc(dd_k)
set(gca,'linewidth',2);
xlabel('���ݵ�','fontsize',12)
ylabel('���ݵ�', 'fontsize',12)
title('k-Means��������س̶�ͼ', 'fontsize',12)
ylabel(colorbar,['�������:', dist_k])
axis square

%% ��ξ���
dist_h = 'spearman';
link = 'weighted';
hidx = clusterdata(bonds, 'maxclust', numClust, 'distance' , dist_h, 'linkage', link);

%���ƾ���Ч��ͼ
figure
F2 = plot3(VX(hidx==1,1), VX(hidx==1,2),VX(hidx==1,3),'r*', ...
           VX(hidx==2,1), VX(hidx==2,2),VX(hidx==2,3), 'bo', ...
           VX(hidx==3,1), VX(hidx==3,2),VX(hidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F2,'linewidth',2, 'MarkerSize',8);
set(gca,'linewidth',2);
xlabel('Ʊ������','fontsize',12);
ylabel('�����÷�','fontsize',12);
ylabel('����������','fontsize',12);
title('��ξ��෽��������')

% ������������س̶�
dist_metric_h = pdist(bonds,dist_h);
dd_h = squareform(dist_metric_h);
[~,idx] = sort(hidx);
dd_h = dd_h(idx,idx);
figure
imagesc(dd_h)
set(gca,'linewidth',2);
xlabel('���ݵ�', 'fontsize',12)
ylabel('���ݵ�', 'fontsize',12)
title('��ξ�������س̶�ͼ')
ylabel(colorbar,['�������:', dist_h])
axis square

% ����ͬ�����ϵ��
Z = linkage(dist_metric_h,link);
cpcc = cophenet(Z,dist_metric_h);
disp('ͬ�����ϵ��: ')
disp(cpcc)

% ��νṹͼ
set(0,'RecursionLimit',5000)
figure
dendrogram(Z)
set(gca,'linewidth',2);
set(0,'RecursionLimit',500)
xlabel('���ݵ�', 'fontsize',12)
ylabel ('��׼����', 'fontsize',12)
 title('��ξ��෨��νṹͼ')

%% ������
%��������
dimension1 = 3;
dimension2 = 1;
net = selforgmap([dimension1 dimension2]);
net.trainParam.showWindow = 0;

%ѵ������
[net,tr] = train(net,bonds');
nidx = net(bonds');
nidx = vec2ind(nidx)';

%���ƾ���Ч��ͼ
figure
F3 = plot3(VX(nidx==1,1), VX(nidx==1,2),VX(nidx==1,3),'r*', ...
           VX(nidx==2,1), VX(nidx==2,2),VX(nidx==2,3), 'bo', ...
           VX(nidx==3,1), VX(nidx==3,2),VX(nidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F3,'linewidth',2, 'MarkerSize',8);
xlabel('Ʊ������','fontsize',12);
ylabel('�����÷�','fontsize',12);
ylabel('����������','fontsize',12);
title('�����緽��������')

%% ģ��C-Means����
options = nan(4,1);
options(4) = 0;
[centres,U] = fcm(bonds,numClust, options);
[~, fidx] = max(U);
fidx = fidx';

%���ƾ���Ч��ͼ
figure
F4 = plot3(VX(fidx==1,1), VX(fidx==1,2),VX(fidx==1,3),'r*', ...
           VX(fidx==2,1), VX(fidx==2,2),VX(fidx==2,3), 'bo', ...
           VX(fidx==3,1), VX(fidx==3,2),VX(fidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F4,'linewidth',2, 'MarkerSize',8);
xlabel('Ʊ������','fontsize',12);
ylabel('�����÷�','fontsize',12);
ylabel('����������','fontsize',12);
title('ģ��C-Means����������')

%% ��˹��Ͼ��� (GMM)
gmobj = gmdistribution.fit(bonds,numClust);
gidx = cluster(gmobj,bonds);

%���ƾ���Ч��ͼ
figure
F5 = plot3(VX(fidx==1,1), VX(fidx==1,2),VX(fidx==1,3),'r*', ...
           VX(fidx==2,1), VX(fidx==2,2),VX(fidx==2,3), 'bo', ...
           VX(fidx==3,1), VX(fidx==3,2),VX(fidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F5,'linewidth',2, 'MarkerSize',8);
xlabel('Ʊ������','fontsize',12);
ylabel('�����÷�','fontsize',12);
ylabel('����������','fontsize',12);
title('��˹��Ϸ���������')

%% k-Means����ȷ����ѵľ��������
% ���Ƽ����������������µ�ƽ������ֵͼ
figure
for i=2:4
    kidx = kmeans(bonds,i,'distance',dist_k);
    subplot(3,1,i-1)
    [~,F6] = silhouette(bonds,kidx,dist_k);
    xlabel('����ֵ','fontsize',12);
    ylabel('�����','fontsize',12);
    set(gca,'linewidth',2);
    title([num2str(i) '���Ӧ������ֵͼ ' ])
    snapnow
end



% ����ƽ������ֵ
numC = 15;
silh_m = nan(numC,1);
for i=1:numC
    kidx = kmeans(bonds,i,'distance',dist_k,'MaxIter',500);
    silh = silhouette(bonds,kidx,dist_k);
    silh_m(i) = mean(silh);
end

%���Ƹ��������Ӧ��ƽ������ֵͼ
figure
F7 = plot(1:numC,silh_m,'o-');
set(gca,'linewidth',2);
set(F7, 'linewidth',2, 'MarkerSize',8);
xlabel('�����', 'fontsize',12)
ylabel('ƽ������ֵ','fontsize',12)
title('ƽ������ֵvs.�����')
%% ���෽������
