% floyd�㷨�ĺ����ļ�
function [d,path]=floyd(a) 
% floyd   - ���·����  
%    a    - ���������ָi��j֮��ľ��몢�����������   
%    d    - ���·�ľ���  
%    path - ���·��·��  
[n,lie]=size(a);   %  nΪa������
d=a; 
path=zeros(n,n); 
for i=1:n 
   for j=1:n
       if d(i,j)~=inf 
           path(i,j)=j; %j��i�ĺ����� 
       end 
   end 
end  
for k=1:n
    for i=1:n 
      for j=1:n 
         if d(i,j)>d(i,k)+d(k,j) 
            d(i,j)=d(i,k)+d(k,j); 
            path(i,j)=path(i,k); 
         end 
      end 
   end 
end 
