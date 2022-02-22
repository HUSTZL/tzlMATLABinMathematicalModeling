clc,clear,close all;
figure;
for step=1:36001
x = 0;
g = 9.8;
M = 69.3+0.7;
dt = 1;
t = 1;
mug = 0.005;
UCLlen = 43300;
H = 1.70;
Cd = 0.2959;
vw = 1;
v(1) = 0;
the = 1/3*pi;
flag = 0;%是否处于转弯时
while (x < UCLlen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve1(t,x,UCLlen)/v(t);
    end
    FA = 0.0293*(H^0.725)*(M^0.425)+0.0604;
    thebefore = the;
    the = theta(x);
    if(the ~= thebefore)
        flag = 1;
    end
    if flag == 1 && v(t) <= 7
        flag = 0;
    end
    if(flag == 0)
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(-(step-1)/36000*2*pi+theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
T(step)=t;
end
xxx = 0:pi/36000*2:2*pi;

function p = powercurve1(t,x,len)
if(x <= len-2000)
    p = 4.78938020./(1+(-0.87373205.*exp(0.98821016*-0.174625949.*t)));
else
    p = 18.75;
end
end

function al = alpha(x)
    al = 0;
end

function t = theta(x)
x = x/1000;
if(x>=0&&x<1.5)    t=1/3*pi;
elseif(x>=1.5&&x<2.9)    t=3/5*pi;
elseif(x>=2.9&&x<6.7)    t=39/45*pi;
elseif(x>=6.7&&x<11.1)    t=8/9*pi;
elseif(x>=11.1&&x<13.5)    t=17/90*pi;
elseif(x>=13.5&&x<17.6)    t=67/90*pi;
elseif(x>=17.6&&x<23.1)    t=pi;
elseif(x>=23.1&&x<28.2)    t=1/18*pi;
elseif(x>=28.2&&x<30.9)    t=11/30*pi;
elseif(x>=30.9&&x<34.8)    t=71/90*pi;
elseif(x>=34.8&&x<40.1)    t=23/30*pi;
elseif(x>=40.1&&x<40.6)    t=1/20*pi;
elseif(x>=40.6&&x<42.1)    t=71/90*pi;
elseif(x>=42.1&&x<43.3)    t=39/45*pi;
end
end
