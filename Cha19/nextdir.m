function [nextroad,nextdistance,nextstate]=nextdir(cari,RoadMap,Car,Roaddistance,Outroad, RoadCarNum)
%% function [nextroad,nextdistance,nextstate]=nextdir(cari,RoadMap,Car,Roaddistance,Outroad, RoadCarNum)
% ����nextdir����cari��������һ��֮���״̬
%Input arguments:
%              cari��1 x 1 int �������
%              RoadMap: n x n array ·�Ŀɴ��Ծ���
%              Car��n x 1 cell ��ǰ��������״̬
%              Roaddistance��n x 1 int ÿ��·�ĳ���
%              Outroad��k x 1 array ���п��ܳ�ȥ��· k �ǳ�����Ŀ
%              RoadCarNum: n x 1 int ��ǰÿ��·���ж��ٳ�
%Output arguments:
%              nextroad: 1 x 1 int 1s�����ڵ�·
%              nextstate: 1 x 1 int dual value(0,1) 1s�󣬸ó��Ƿ���������
%              nextdistance��1 x 1 int 1s����·�Ͼ�·��ڵ��߼�����
%% 
    car = Car{cari}; % ��ǰ���ڿ��ǵĳ�
    nextroad = car.road;
    nextdistance = car.distance;
     if car.distance >= Roaddistance(Car{cari}.road) && ismember(car.road,Outroad);
        nextstate = 0;
        return;
    else
        nextstate = 1;
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
    