%% GA�㷨�������������
% ��MATLAB��ѧ��ģ������ʵ����(��MATLAB����ѧ��ģ�е�Ӧ�á�������)�����������磬׿���䡢���������. 
 %% �������������
load('usborder.mat','x','y','xx','yy');

cities = 40;
locations = zeros(cities,2);
n = 1;
while (n <= cities)
    xp = rand*1.5;
    yp = rand;
    if inpolygon(xp,yp,xx,yy)
        locations(n,1) = xp;
        locations(n,2) = yp;
        n = n+1;
    end
end
plot(locations(:,1),locations(:,2),'bo');
xlabel('���еĺ�����x'); ylabel('���е�������y'); 
grid on

%% ������о���

distances = zeros(cities);
for count1=1:cities
    for count2=1:count1
        x1 = locations(count1,1);
        y1 = locations(count1,2);
        x2 = locations(count2,1);
        y2 = locations(count2,2);
        distances(count1,count2)=sqrt((x1-x2)^2+(y1-y2)^2);
        distances(count2,count1)=distances(count1,count2);
    end
end


%% ����Ŀ�꺯��
FitnessFcn = @(x) traveling_salesman_fitness(x,distances);

my_plot = @(options,state,flag) traveling_salesman_plot(options, ...
    state,flag,locations);

%% �����Ż����Բ�ִ���Ŵ��㷨���

options = optimoptions(@ga, 'PopulationType', 'custom','InitialPopulationRange', ...
                            [1;cities]);

options = optimoptions(options,'CreationFcn',@create_permutations, ...
                        'CrossoverFcn',@crossover_permutation, ...
                        'MutationFcn',@mutate_permutation, ...
                        'PlotFcn', my_plot, ...
                        'MaxGenerations',500,'PopulationSize',60, ...
                        'MaxStallGenerations',200,'UseVectorized',true);

numberOfVariables = cities;
[x,fval,reason,output] = ...
    ga(FitnessFcn,numberOfVariables,[],[],[],[],[],[],[],options);

