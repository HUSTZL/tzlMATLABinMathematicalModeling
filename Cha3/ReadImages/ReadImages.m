%% ��ȡͼƬ
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc, clear, close all
a1=imread('000.bmp');
[m,n]=size(a1);
%% ������ȡͼƬ
dirname = 'ImageChips';
files = dir(fullfile(dirname, '*.bmp'));
a=zeros(m,n,19);
pic=[];
for ii = 1:length(files)
  filename = fullfile(dirname, files(ii).name);
  a(:,:,ii)=imread(filename);
  pic=[pic,a(:,:,ii)];
end
double(pic);
figure
imshow(pic,[])
