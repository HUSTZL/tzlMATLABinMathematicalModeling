clc,clear
delta_t=1/24;
xm=217.6; 
Com1=0.0002;Com2=0.0002;
tmax=366; 
T=16;
x10=25; x20=25; 
ER1=5; ER2=3; 
Ms1=14.8; Ms2=15.2; 
MT1=-0.154*ER1+2.5953;MT2=-0.154*ER2+2.5953; 
f=3.7*10^-5*T-2.3*10^-5;
show_x1=zeros(1,tmax);show_x2=zeros(1,tmax);
k=0;
x1=x10;x2=x20;
show_x1(1)=x10;show_x2(1)=x20;
for t=1:delta_t:tmax
 Env1=exp(4*log(2)*((Moisture(t)-Ms1)/MT1)^2);
 Env2=exp(4*log(2)*((Moisture(t)-Ms2)/MT2)^2);
 survive1=(x1>=5);
 survive2=(x2>=5);
 x1=x1+ER1/x10*x1*(survive1-x1/xm*Env1-Com2*x2*x1)*delta_t;
 x2=x2+ER2/x10*x2*(survive2-x2/xm*Env2-Com1*x1*x2)*delta_t;
 if (k*delta_t)>=1
 k=0;
 show_x1(round(t))=x1;
 show_x2(round(t))=x2;
 end
 k=k+1;
end
figure,plot([0:tmax-1],1.5*show_x1,'b');
axis([0 tmax-1 0 220]);xlabel('t/day','FontSize',15);ylabel('x1(t) x2(t)/ mm','FontSize',15);title('The Change of x1(t) and x2(t)','FontSize',15);
hold on
plot([0:tmax-1],1.5*show_x2,'r');
DR=1.5*f*(show_x1+show_x2);
figure,plot([0:tmax-1],DR,'color',[238/255 118/255 0],'LineWidth',2);
axis([0 tmax-1 0 0.2]);xlabel('t/day','FontSize',15);ylabel('¦Ç_D¡¯(t) /day^-^1','FontSize',15);title('The Change of the DecompostionSpeed','FontSize',15);
E=mean(DR);
D=var(DR);
function M=Moisture(t)
 M=15+0.2*sin(2*pi*3/365*t)-0.2*sin(2*pi/365*t);
end