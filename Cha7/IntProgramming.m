% 0-1�����滮
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc, clear, close all
f=[-3; 2; -5];
intcon=3;
A=[1 2 -1; 1 4 1; 1 1 0; 0 4 1];
b=[2; 4; 3; 6];
lb=[0, 0 , 0];
ub=[1,1,1];
Aeq=[0,0,0];
beq=0;
x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub)