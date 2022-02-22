% x=[0 40 55 59];
% y=[3.5 4.25 4.83 7.23]
% ft = fittype( 'k/(1-a*exp(-b*x))^(1/(1-m))', 'independent', 'x', 'dependent', 'y' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Lower = [0 0 0 0];
% opts.StartPoint = [0 0 16 0];
% [fitresult, gof] = fit( x', y', ft, opts )
% figure
% t = 0:0.1:60;
% P = fitresult(t);
% plot(P)
% figure
% P(1) = 15.6
% for t = 1:6000
%     P(t+1) = P(t) - 0.01*(P(t)*0.1*(1-P(t)/16));
% end
% plot(P)
clc,clear,close all;
figure
subplot(2,2,1)
X=[18.09	20.34	15.84
9.48	10.62	8.34
6.10	6.7	5.5
4.86	5.28	4.44]
X = X'
boxplot(X,'BoxStyle','filled','Colors',[0.3010,0.7450,0.9330])
hold on
Y = [24.04	11.50	7.60	6.40
23.77	11.39	7.50	6.31
23.50	11.27	7.39	6.22
23.22	11.16	7.29	6.13
22.95	11.04	7.19	6.04
22.68	10.93	7.08	5.96
22.41	10.81	6.98	5.87
22.14	10.70	6.88	5.78
21.86	10.58	6.77	5.69
22.95	11.04	7.19	6.04
]
boxplot(Y,'BoxStyle','filled','Colors',[0,0.4470,0.7410])
tick={'5s' '1min' '5min' 'FT'};
set(gca,'XTickLabel',tick);
ylabel('P/(Watts per kg)')
title('STRAVA and COGGAN Data(Men)')

subplot(2,2,3)
X=[15.22	17.35	13.09
7.23	8.02	6.44
4.83	5.15	4.51
4.04	4.40	3.68]
X = X'
boxplot(X,'BoxStyle','filled','Colors',[0.8500 0.3250 0.0980])
hold on
Y = [19.42	9.29	6.61	5.69
19.2	9.2	6.52	5.61
18.99	9.11	6.42	5.53
18.77	9.02	6.33	5.44
18.56	8.93	6.24	5.36
18.34	8.84	6.15	5.28
18.13	8.75	6.05	5.2
17.91	8.66	5.96	5.12
17.7	8.56	5.87	5.03
18.56	8.93	6.24	5.36
]
boxplot(Y,'BoxStyle','filled','Colors',[0.6350 0.0780 0.1840])
tick={'5s' '1min' '5min' 'FT'};
set(gca,'XTickLabel',tick);
ylabel('P/(Watts per kg)')
title('STRAVA and COGGAN Data(Women)')


t = 0:0.01:60.2;
P = 4.78938020./(1+(-0.87373205.*(0.84150179.^t))); %Men
P(6000:6020) = 18.75;
subplot(2,2,2)
plot(t,P);
set(gca,'Xtick',[0.1 1 2 5 10 30 60]);
set(gca,'Xscale','log');
xlabel('t/min')
ylabel('P/(Watts per kg)')
title('male Time Trial Specialist')


subplot(2,2,4)
P = 1.64581665./(1+(-0.90360547.*(0.85475672.^t))); %Women
P(6000:6020) = 8.23;
plot(t,P,'r');
set(gca,'Xtick',[0.1 1 2 5 10 30 60]);
set(gca,'Xscale','log');
xlabel('t/min')
ylabel('P/(Watts per kg)')
title('female Time Trial Specialist')
