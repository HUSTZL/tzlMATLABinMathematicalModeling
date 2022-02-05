
% x = -3:0.1:3
% [x,y] = meshgrid(x)
% z = sin(x.*y).*exp(x.*y./5)
% for j = 1:30
%     mesh(cos(4*pi*j/30)*z,z)
%     m(j) = getframe
% end
% movie(m,3)

clear,clc
n = 100, s = 0.002
axis square
grid off
x = rand(n,1)-0.5
y = rand(n,1)-0.5
h = plot(x, y, '.')
set(h, 'MarkerSize', 18)
while 1
    x = x + s*rand(n,1);
    y = y + s*rand(n,1);
    set(h, 'Xdata', x, 'Ydata', y)
%     if all(x>1) & all(y>1)
%         break
%     end
    drawnow
end