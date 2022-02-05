%% PCA���ݽ�άʵ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��ȡ����
A=xlsread('Coporation_evaluation.xlsx', 'B2:I16');

% Transfer orginal data to standard data
a=size(A,1);   % Get the row number of A
b=size(A,2);   % Get the column number of A
for i=1:b
    SA(:,i)=(A(:,i)-mean(A(:,i)))/std(A(:,i));  % Matrix normalization
end

% Calculate correlation matrix of A.
CM=corrcoef(SA);

% Calculate eigenvectors and eigenvalues of correlation matrix.
[V, D]=eig(CM);

% Get the eigenvalue sequence according to descending and the corrosponding
% attribution rates and accumulation rates.
for j=1:b
    DS(j,1)=D(b+1-j, b+1-j);
end
for i=1:b
    DS(i,2)=DS(i,1)/sum(DS(:,1));
    DS(i,3)=sum(DS(1:i,1))/sum(DS(:,1));
end

% Calculate the numvber of principal components.
T=0.9;  % set the threshold value for evaluating information preservation level.
for K=1:b
    if DS(K,3)>=T
        Com_num=K;
        break;
    end
end

% Get the eigenvectors of the Com_num principal components
for j=1:Com_num
    PV(:,j)=V(:,b+1-j);
end

% Calculate the new socres of the orginal items
new_score=SA*PV;

for i=1:a
    total_score(i,2)=sum(new_score(i,:));
    total_score(i,1)=i;
end
new_score_s=sortrows(total_score,-2);

%% ��ʾ���
disp('����ֵ�������ʣ�')
DS
disp('��ֵT��Ӧ�����ɷ���������������')
Com_num
PV
disp('���ɷַ�����')
new_score
disp('���ɷַ�������')
new_score_s















