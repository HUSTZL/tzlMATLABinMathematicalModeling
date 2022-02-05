clear,clc
t = 'sqrt(i)'
for i = 1: 10
    s(i) = {char(['sqrt ', int2str(i), '= ', num2str(eval(t))])}
end
s(:)

clear,clc
a = rand(1,10)
fid = fopen('data1.txt','w')
fprintf(fid,'%8.4f',a)
fclose(fid)
load data1.txt
data1

clear,clc
a = rand(4,10)
dlmwrite('data2.txt',a,'delimiter','\t')

clear,clc
m = 1:10
for i = 1:length(m)
    n = m.^2
    nf = [m', n']
    t = char(['nf',int2str(i),'=nf'])
    eval(t)
    save(['data',int2str(i)],['nf',int2str(i)])
end

clear,clc
load data1.mat
