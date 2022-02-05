function [nextroad,nextdistance,nextstate]=nextdir_red(cari,RoadMap,Car,Roaddistance,Outroad, RoadCarNum)
%% ����nextdir����cari��������һ��֮���״̬
%Input arguments��
%                cari��1 x 1 int �������
%                RoadMap: n x n array ·�Ŀɴ��Ծ���
%                Car��n x 1 cell ��ǰ��������״̬
%                Roaddistance��n x 1 int ÿ��·�ĳ���
%                Outroad��k x 1 int ���п��ܳ�ȥ��· k�ǳ�����
%                RoadCarNum: n x 1 int ��ǰÿ��·���ж��ٳ�
%Output arguments:
%                nextroad: 1 x 1 int 1s�����ڵ�·
%                nextdistance��1 x 1 int 1s����·�Ͼ�·��ڵ��߼�����
%                nextstate: 1 x 1 int dual value(0,1)1s�󣬸ó��Ƿ���������
%% 
    car = Car{cari}; % ��ǰ���ڿ��ǵĳ�
    nextstate = 1;
    nextroad = car.road;
    nextdistance = car.distance;
    if car.distance >= Roaddistance(Car{cari}.road) && ismember(car.road,Outroad);
        return;
    end
    nextdistance = nextdistance + 1;
    if(Roaddistance(nextroad) < nextdistance)
        nextroad = chooseRoad(cari,nextroad,RoadMap,Car,Roaddistance, RoadCarNum); %%%����·��ѡ��·�ķ���
        nextdistance = 1;
    end
    for i = 1 : (cari - 1)
           if(Car{i}.state == 1 && Car{i}.road == nextroad && Car{i}.distance == nextdistance)
               % ���������ߣ�
               nextroad = car.road;
               nextdistance = car.distance;
           end
    end
    