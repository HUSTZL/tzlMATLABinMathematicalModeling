%% 2016.09  ȫ����ѧ����ѧ��ģ���� B �� С�����ŶԵ�·ͨ�е�Ӱ��
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
%% ��������
clc;
clear;
Tmax = 200;        %���ǵ�ʱ�������
carnum = 0;         %carnum  �ǵ�ǰͨ���ĳ�������Ŀ
fieldCarNum = 0;    %fieldCarNum ����С���ĳ�����
beta = 5;           %1-alpha / 10,Ϊ���ֳ��ĸ��ʣ����ֳ����� 
fieldCapure = 800;  %С���ڵ�·�ĳ�����
fieldDistance = 80; %С���ڵ�·���߼�����
fRpb = 0.8;         %�������г�����ϵ��
R = 0.5;            %��·����С���ı���
L1 = 0.005;         %������,km
h = 0.0025;         %��׼���ͳ�ͷʱ��
alpha = 2*pi / 3;   %ת��Ƕ�
mu = 0.18;          %������ϵ��
v = 50;             %�����ٶ�
t_avg = L1 / v ;    %��ͨ����³���ֱ��ͨ����������ƽ����ʱ
ER = (L1 + alpha * R)/(h * sqrt(127 * R * mu));
                    %��ת��ת��ϵ��
fR = 100/(100 + R * (ER - 1));
                    %��ת����ϵ��
theta = 0;          %���������ʱ��Ӱ������
delay = zeros(Tmax, 1); %��¼�����ʱ
T = 20; %·������
Tg = 5; %�̵�ʱ��
Car = cell(carnum,1);  %Car �����еĳ��ļ���
Car0 = cell(carnum,1); %Car �����еĳ��ļ���
car = struct('road',0,'distance',0,'state',0); %road �ǵ�ǰ�����ڵĵ�·��distance��ʾ������·�ϵ�λ��,state��ʾ�Ƿ��������1�����棬0������
t = 0; %��ǰʱ��
Dt = cell(t,1); %ÿ��ʱ�̵�ƽ������
Dt0 = cell(t,1); %ÿ��ʱ�̵�ƽ������
Light = 0; % Light ��ʾ��ǰ���Ǻ��0�������̵�1

roadnum = 4;  %roadnum �����еĵ�·��Ŀ
Outroad = []; % �����������·
Outroad(1) = 4;
Inroad = [2,3,]; %�����������·
FieldRoad = []; %С���ڵ�·
FieldRoad(1) = 3;

Troad = zeros(roadnum,1);%ÿ��·�ϵ�·������
Tgroad = zeros(roadnum,1);%ÿ��·���̵�ʱ��
RoadMap = zeros(roadnum,roadnum); %·�Ŀɴ��Ծ���
RoadMap0 = zeros(roadnum,roadnum); %·�Ŀɴ��Ծ���
Roadcapture = zeros(roadnum,1); %Roadcapture ·����Ƴ�����
Roadcarnum = zeros(roadnum,1); %Roadcarnum ·��ǰ�еĳ�����
Roadcarnum0 = zeros(roadnum,1); %Roadcarnum ·��ǰ�еĳ�����
Roaddistance = zeros(roadnum,1);%Roaddistance ·�ľ���
Roaddt = zeros(roadnum,1); %Roaddt ÿ��·�ϵ�ƽ���ӳ�ʱ��


Roadcapture = [1000,1000,1000,1];
Roadcapture(FieldRoad) = fieldCapure;
Roadcapture = Roadcapture';
Roaddistance = [100,100,100,1];
Roaddistance(FieldRoad) = fieldDistance;

Troad(:) = 20;
Tgroad(:) = 5;

RoadMap = [0,0,0,0;
           1,0,0,0;
           1,0,0,0;
           0,1,1,0]; %%С���ڲ���ͨ�ɴ��Ծ���
RoadMap0 = [0,0,0,0;
            1,0,0,0;
            0,0,0,0;
            0,1,0,0];

myres = zeros(500,4);
Flag = [0,1,0,0]'; 
mainflow = 3600 * (1 - beta / 10);         %��·�ĳ�����
%% �������
for t = 1:Tmax
    %%%%%%�жϵ�ǰ�Ƿ��г�����0û�У�1��
    Dt{t} = 0;
    Dt0{t} = 0;
    ra = rand();
    if ra >= beta / 10
        ra = 1;
    else
        ra = 0;
    end
    %%%%%%���ӳ�������,���³������
    if ra == 1
        carnum = carnum+1;
        car.road = 1;
        car.distance = Roaddistance(1);
        car.state = 1;
        Car{carnum} = car;
        Car0{carnum} = car;
        Roadcarnum(1) = Roadcarnum(1)+1;
        Roadcarnum0(1) = Roadcarnum0(1)+1;
    end
   
    %%%%%%�жϵ�ǰ���̵����
    Light = mod(t,T);
    if Light <= Tg
        Light = 1;
    else
        Light = 0;
    end
    
    for cari = 1:carnum
        if(Car0{cari}.state == 1)
        %%������С������ʱ  
        if Light == 1  %%%�̵�ʱ
            [nextroad,nextdistance,nextstate] = nextdir(cari,RoadMap0,Car0,Roaddistance,Outroad,Roadcarnum0); %%%����nextdir����cari��������һ�����ڵ�·����·�ϵľ���
        else %%%%���ʱ
            [nextroad,nextdistance,nextstate] = nextdir_red(cari,RoadMap0,Car0,Roaddistance,Outroad,Roadcarnum0);
        end
        Roadcarnum0(Car0{cari}.road) =  Roadcarnum0(Car0{cari}.road)-1;
        Car0{cari}.road = nextroad;
        Car0{cari}.distance = nextdistance;
        Car0{cari}.state = nextstate;
        if nextstate == 1
            Roadcarnum0(nextroad) =  Roadcarnum0(nextroad)+1;  %%%%%%��ǰ����·�ϵĳ�������
        end
        end
        %%����С������ʱ
    %   disp(strcat('car', num2str(cari)));
        if(Car{cari}.state == 1)
        if Light == 1  %%%�̵�ʱ
            [nextroad,nextdistance,nextstate] = nextdir(cari,RoadMap,Car,Roaddistance,Outroad,Roadcarnum); %%%����nextdir����cari��������һ�����ڵ�·����·�ϵľ���
        else %%%%���ʱ
            [nextroad,nextdistance,nextstate] = nextdir_red(cari,RoadMap,Car,Roaddistance,Outroad,Roadcarnum);
        end
        myres(t, 1) = nextroad;
        myres(t, 2) = nextdistance;
        myres(t, 3) = nextstate;
        myres(t, 4) = cari;
        Roadcarnum(Car{cari}.road) =  Roadcarnum(Car{cari}.road)-1;
        Car{cari}.road = nextroad;
        Car{cari}.distance = nextdistance;
        Car{cari}.state = nextstate;
        if nextstate == 1
            Roadcarnum(nextroad) =  Roadcarnum(nextroad)+1;  %%%%%%��ǰ����·�ϵĳ�������
        end
        end
    end
    if( ra == 1 && ismember(nextroad, FieldRoad) )
            fieldCarNum = fieldCarNum + 1;
            theta = theta + 1;
    else
        if(theta >= 0.3)
            theta = theta - 0.3;
        else
            theta = 0;
        end
    end
    if(carnum > 0)
        R = R * 0.5 + 0.5 * fieldCarNum / carnum;
        ER = (L1 + alpha * R)/(h * sqrt(127 * R * mu));%��ת��ת��ϵ��
        fR = 100/(100 + R * (ER - 1));%��ת����ϵ��
        x = ( mainflow) / Roadcapture(1); %��·���Ͷ�
        C1 = x * (fRpb + fR);               %������ͨ������
        NDT = (1/C1 - t_avg) * (1/t_avg + 1) * t_avg / 2; %�źŽ���·��ƽ������
        Dt{t} = theta * NDT;
        delay(t) = Dt{t};
    end
    %%%%%%����ÿ��·��ƽ������ʱ��
    dt = ((0.5*Troad).*(1-Tgroad./Troad))./(1-min(1,Roadcarnum.*(720./Roaddistance')./Roadcapture).*(Tgroad./Troad)).*Flag;
    Dt{t} = Dt{t} + sum(dt);
        
    dt0 = ((0.5*Troad).*(1-Tgroad./Troad))./(1-min(1,Roadcarnum0.*(720./Roaddistance')./Roadcapture).*(Tgroad./Troad)).*Flag;
    Dt0{t} = Dt0{t} + sum(dt0);
end
%% ��ͼ
matDt = cell2mat(Dt);
matDt0 = cell2mat(Dt0);
plot([1:Tmax],matDt,'-','markersize',5);
hold on;
plot([1:Tmax],matDt0,'-','markersize',5);
legend('С������','С��δ����')
grid on;
dtDelta = cell2mat(Dt0) - cell2mat(Dt);
save(strcat(num2str(alpha), 'dtDelta_7.mat'), 'dtDelta');
save(strcat(num2str(alpha), 'Dt_7.mat'), 'Dt');
save(strcat(num2str(alpha), 'Dt0_7.mat'), 'Dt0');

