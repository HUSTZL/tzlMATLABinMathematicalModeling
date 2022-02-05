figure
x = 0:0.1:20
y = rand(size(x))
subplot(1,2,1)
plot(x,y)
subplot(1,2,2)
hist(round(20*x),50)

figure
t = 0:pi/50:10*pi
plot3(sin(t),cos(t),t)
xlabel('sin t')
ylabel('cos t')
zlabel('t')

figure
x = -3:0.1:3
y = -5:0.1:5
[X, Y] = meshgrid(x, y)
z = (sin(X.*Y)./(X.*Y+eps))
mesh(X,Y,z)

figure
fplot("fun1",[-3,3])
disp(fun1(2))