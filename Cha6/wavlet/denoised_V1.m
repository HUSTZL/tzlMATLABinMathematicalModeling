% С��ȥ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc, clear all, close all,
load nelec.mat;
sig = nelec;
denPAR = {[1 94 5.9 ; 94 1110 19.5 ; 1110 2000 4.5]};
wname = 'sym4';
level = 5;
sorh  = 's'; % type of thresholding
thr = 4.5;
[sigden_1,~,~,perf0,perfl2] = wdencmp('gbl',sig,wname,level,thr,sorh,1);
res = sig-sigden_1;
subplot(3,1,1);plot(sig,'r');       axis tight
title('Original Signal')
subplot(3,1,2);plot(sigden_1,'b');  axis tight
title('Denoised Signal');
subplot(3,1,3);plot(res,'k');       axis tight
title('Residual');
% perf0,perfl2