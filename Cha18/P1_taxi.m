%% ���⳵���������������
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
clc, clear, close all
%% ���ݽṹ���
% passengers:
% [����������꣬�����������꣬Ŀ�ĵغ����꣬Ŀ�ĵ������꣬�������]
% ��[xs,ys,xd,yd,l]
% taxis
% [���⳵λ�ú����꣬���⳵λ�������꣬���⳵��ռ�����]
% ��[x_taxi,y_taxi,lo]
r_valid = 2/10;%���⳵��Ч���ǰ뾶
xmax = 111*cos(pi*34/180)*1.4;
ymax = 0.7*111;
xmax = xmax/10;
ymax = ymax/10;
psnger_total = 80;
taxi_total = 152;
%������5000��������
for i = 1:psnger_total
    passengers(i,:) = gen_passenger();
end
for i = 1:taxi_total
    taxis(i,:) = gen_taxi();
end
figure
scatter(taxis(:,1)*10,taxis(:,2)*10)
xlabel('x(km)')
ylabel('y(km)')
all_B = [];
all_K = [];
for i = 1:200
    %% ���ȸ��³��⳵״̬
    lc = taxis(:,3) - 0.01;%���⳵��ռ�����
    lc(lc < 0) = 0;
    taxis(:,3) = lc;
    %�ճ����һ������ǰ��0.01
    valid_lines = find( lc == 0 );
    all_K = [all_K,1-length(valid_lines)/taxi_total]; 
    for m = 1:length(valid_lines)
        k = valid_lines(m);
        while(1)
            degree = 2*pi*rand();%���з���
            new_x = taxis(k,1) + 0.01.*cos(degree);
            new_y = taxis(k,2) + 0.01.*sin(degree);
            if(new_x>=0 && new_x<=xmax && new_y>=0 && new_y<=ymax)
                taxis(k,1:2) = [new_x,new_y];
                break
            end
        end
    end
    
    %% �˿ͼ���ϵͳ
    add_passengers_total = 4;%round(normrnd(10,3));
    add_passengers = zeros(add_passengers_total,5);
    for n = 1:add_passengers_total
        add_passengers(n,:) = gen_passenger();
    end
    passengers = [passengers;add_passengers];    
    %% ������˿���Ұ�ڳ��⳵��Ŀ  
    for j = 1:length(passengers)  
        p = passengers(j,:);
        if isnan(p(1))
            continue
        end
        temp_taxis = taxis; 
        %��ռ�õĳ��⳵�������
        invalid_lines = find(temp_taxis(:,3)>0);
        temp_taxis(invalid_lines,:) = nan;
       %% Ȼ���ǳ˿ͳ˳�
        r = sqrt((temp_taxis(:,1)-p(1)).^2+(temp_taxis(:,2)-p(2)).^2);
        taxi_num = find(r<r_valid);%��Ұ��Χ�ڵĳ��� 
        if isempty(taxi_num)%��Ұ��û�г�����һλ�˿�
            continue;
        else
            %���ѡһ������
            index = round(rand()*(length(taxi_num)-1))+1;
            taxi_num = taxi_num(index);
            taxis(taxi_num,3) = p(5) + sqrt((taxis(taxi_num,1)-p(1))^2+(taxis(taxi_num,2)-p(2))^2);%�˳˿�p�����ĳ��⳵��ռ��
            taxis(taxi_num,1) = p(3);taxis(taxi_num,2) = p(4);%������µ�Ŀ�ĵ�
            passengers(j,:) = nan;%���³˿�״̬���ϳ��ĳ˿ͱ�Ϊnan���Ƴ�ϵͳ
        end
    end
        all_B = [all_B,calcu_b(passengers,taxis)];
end
%% ������ӻ�
figure
hold on
scatter(taxis(:,1)*10,taxis(:,2)*10,'g*')
legend('��ʼλ��','һ��ʱ���λ��')

%20���ݻ���ŵõ�ƽʱ״̬����ֻ����20��֮�������
pos = (20:length(all_B));
figure
plot((pos-20)/4.5,all_B(pos));
xlabel('ʱ��(����)')
ylabel('��Ŀ��ƽ���')
figure
plot((pos-20)/4.5,all_K(pos));
xlabel('ʱ��(����)')
ylabel('���������')

figure
res = sqrt( ((all_K-0.66)./0.66).^2 + (all_B-1).^2 );
plot((pos-20)/4.5,res(pos));
xlabel('ʱ��(����)')
ylabel('���費ƽ���')