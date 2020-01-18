function [trial,tes2]=normal(x,x1)
[N,n]=size(x);
for i=1:n
   trial(:,i)=abs(x(:,i))/abs(max(x(:,i)));
    
end
[M,m]=size(x1);
for i=1:m
tes2(:,i)=abs(x1(:,i))/abs(max(x1(:,i)));
end
%trial1=data1/abs(max(data1));
%tes3=tes1/abs(max(tes1));