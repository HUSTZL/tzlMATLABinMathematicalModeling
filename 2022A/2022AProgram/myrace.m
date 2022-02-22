clc,clear,close all;
figure;
subplot(4,1,1);
x = 0;
g = 9.8;
M = 69.3+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2259;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve1(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
T = 0:dt:t-1;
plot(T,v,'Color','b');
xlabel('t/s');
ylabel('v/(m per s)');
set(gca,'XLim',[0 2300])
title('male Time Trail Specialist');
t

clear;
subplot(4,1,2);
x = 0;
g = 9.8;
M = 69.3+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2359;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve2(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
T = 0:dt:t-1;
plot(T,v,'Color','k');
xlabel('t/s');
ylabel('v/(m per s)');
set(gca,'XLim',[0 2300])
title('male Climber');
t

clear;
subplot(4,1,3);
x = 0;
g = 9.8;
M = 69.3+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2259;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve3(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
T = 0:dt:t-1;
plot(T,v,'Color','c');
xlabel('t/s');
ylabel('v/(m per s)');
set(gca,'XLim',[0 2300])
title('male Sprinter');
t

clear;
subplot(4,1,4);
x = 0;
g = 9.8;
M = 57.2+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2259;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve4(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
T = 0:dt:t-1;
plot(T,v,'Color','r');
xlabel('t/s');
ylabel('v/(m per s)');
title('female Time Trail Specialist');
t
clear;
x = 0;
g = 9.8;
M = 57.2+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2359;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve5(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
t
clear;
x = 0;
g = 9.8;
M = 57.2+0.7;
dt = 1;
t = 1;
mug = 0.005;
mylen = 28800;
H = 1.70;
Cd = 0.2259;
vw = 4;
v(1) = 0;
the= 0;
flag = 0;%是否处于转弯时
while (x < mylen)
    if(t==1)
        F = 0.3*M*g;
    else
        F = M*powercurve6(t,x,mylen)/v(t);
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
        a = (F - (M*g*sin(alpha(x))) - mug*M*g*cos(alpha(x)) -Cd*FA*(v(t)*v(t)+vw*vw+2*v(t)*vw*cos(theta(x))))/M;
    else
        a = -v(t)/3*2;
    end
    v(t+1) = v(t)+a*dt;
    x = x+v(t+1)*dt;
    t = t+dt;
end
t

function p = powercurve1(t,x,len)
if(x <= len-2000)
    p = 4.7894./(1+(-0.87373205.*exp(0.98821016*-0.1746.*t)));
else
    p =  18.7500 ;
end
end

function p = powercurve2(t,x,len)
if(x <= len-2000)
    p = 5.031625./(1+(-0.87373205.*exp(0.98821016*-0.1218.*t)));
else
    p = 15.1200;
end
end

function p = powercurve3(t,x,len)
if(x <= len-2000)
    p = 4.8639./(1+(-0.87373205.*exp(0.98821016*-0.2619.*t)));
else
    p = 28.1300;
end
end

function p = powercurve4(t,x,len)
if(x <= len-2000)
    p = 1.6458./(1+(-0.87373205.*exp(0.98821016*-0.174626.*t)));
else
    p = 18.75;
end
end

function p = powercurve5(t,x,len)
if(x <= len-2000)
    p = 1.729061./(1+(-0.87373205.*exp(0.98821016* -0.1218 .*t)));
else
    p = 15.1200   ;
end
end

function p = powercurve6(t,x,len)
if(x <= len-2000)
    p = 1.6715./(1+(-0.87373205.*exp(0.98821016*-0.2619.*t)));
else
    p = 28.1300;
end
end

function al = alpha(x)
x = x/1000;
if(x>=0&&x<2.2)    al=0;
elseif(x>=2.2&&x<4.1)    al=0.0279;
elseif(x>=4.1&&x<6.1)    al=-0.0290;
elseif(x>=6.1&&x<8.3)    al=0.0962;
elseif(x>=8.3&&x<11)    al=-0.0533;
elseif(x>=11&&x<16.7)    al=0;
elseif(x>=16.7&&x<24.1)    al=-0.0078;
elseif(x>=24.1&&x<28.8)    al=0;
end
end

function t = theta(x)
x = x/1000;
if(x>=0&&x<2.2)    t=0;
elseif(x>=2.2&&x<3.4)    t=1/2*pi;
elseif(x>=3.4&&x<4.1)    t=0;
elseif(x>=4.1&&x<8.3)    t=25/36*pi;
elseif(x>=8.3&&x<11)    t=11/36*pi;
elseif(x>=11&&x<11.6)    t=21/36*pi;
elseif(x>=11.6&&x<16.7)    t=0;
elseif(x>=16.7&&x<19.4)    t=2/3*pi;
elseif(x>=19.4&&x<24.1)    t=5/12*pi;
elseif(x>=24.1&&x<26.9)    t=17/20*pi;
elseif(x>=26.9&&x<28.8)    t=2/3*pi;
end
end
