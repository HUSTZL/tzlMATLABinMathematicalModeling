clc
clear all
syms x;
f=((4.83.*(x.^59)-15.22)./10.39-((3.5.*(x.^719)-4.83.*(x.^59))./1.33))
p0=0.5
tol=1e-6
maxK=1

[p,k]=NTM(f,p0,tol,maxK);

DP=sprintf("使用牛顿迭代法法迭代%d次，计算%s=0以%g为迭代初始值的解为：%g",k,f,p0,p);
disp(DP);

function [p,k]=NTM(f,p0,tol,maxK)
%p0表示迭代初始值
%f表示要求解的方程
%maxK表示规定的最大迭代次数
%tolr表示允许误差
%k表示最终迭代的次数
%p表示最终迭代的值
    syms x;
    Pbefore=p0;
    k=2;
    df=diff(f);     %利用diff()函数计算f(x)的导数
   
    Pnow=Pbefore-subs(f,x,Pbefore)/subs(df,x,Pbefore); %第二次迭代的结果
    while k<=maxK
        err=abs(Pnow-Pbefore);    %err表示相邻的迭代值的差值
        if(err<tol)
            fprintf('迭代%d次即可满足允许误差值退出\n',k-1);
            break;
        end
        k=k+1;
        Pnow=Pbefore-subs(f,x,Pbefore)/subs(df,x,Pbefore);  %迭代
        Pbefore = Pnow;
    end      %共迭代了k-1次
    if(k-1==maxK) 
        disp("超过最大迭代次数！");
    end
    p=Pnow; 
    k=k-1;
end