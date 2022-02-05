function [nextroad] = chooseRoad(cari,currentRoad, RoadMap,Car,Roaddistance, RoadCarNum)
%% function [nextroad] = chooseRoad(cari,currentRoad, RoadMap,Car,Roaddistance, RoadCarNum)
%Input arguments��
%               cari��1 x 1 int  �������
%               currentRoad:1 x 1 int ��ǰ���ڵ�·�ı��
%               RoadMap: n x n array ·�Ŀɴ��Ծ���
%               Car��n x 1 cell ��ǰ��������״̬
%               Roaddistance��n x 1 int ÿ��·�ĳ���
%               RoadCarNum: n x 1 int ��ǰÿ��·���ж��ٳ�
%Output arguments��
%               nextroad: 1 x 1 int ѡ�����һ��·�ı��
%%
k1 = 1;%��������
k2 = 1;
nextroad = 0;
min = intmax();
roadNum = length(RoadMap);
% disp(strcat('currentroadNum', num2str(currentRoad)));
myNeighbor = zeros(roadNum);
myNeighborNum = 0;
for i = 1 : roadNum
    if(RoadMap(i, currentRoad) == 0) %��·��ͨ�����
        continue;
    end
    myNeighborNum = myNeighborNum + 1;
    myNeighbor(myNeighborNum) = i;
    % disp(strcat('roadNum', num2str(i)));
    
    % ��������ѡ��
    myvalue = 0;
    for j = 1 : (cari - 1)
        if(Car{j}.state == 1 && Car{j}.road == i && Car{j}.distance == 1)
            %�ж�������·�Ƿ���Ҫ��
            myvalue = intmax() - 100000;
            break;
        end
    end
    %����ÿ��·��ָ��
    myvalue = myvalue + k1 * Roaddistance(i) + k2 * RoadCarNum(i);
    
    if(myvalue < min)
        min = myvalue;
        nextroad = i;
    end
    
    %     disp(i);
    %    disp(myvalue);
    
end
% �漴ѡ��
% nextroad = myNeighbor(ceil(rand() * (myNeighborNum - 1)) + 1);


