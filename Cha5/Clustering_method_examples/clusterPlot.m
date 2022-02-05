function H1 = clusterPlot(C, id, mname)
H1 = plot3(C(id==1),'r*', ...
     C(id==2), 'bo', ...
     C(id==3), 'kd');     
set(gca,'linewidth',2);
set(H1,'linewidth',2, 'MarkerSize',8);
xlabel('���','fontsize',12);
ylabel('�÷�','fontsize',12);
zlabel('�÷�','fontsize',12);
title(mname);