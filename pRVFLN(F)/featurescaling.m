function [normalizeddata]=featurescaling(data)
x=mean(data);
y=max(data);
z=min(data);
range=y-z;
for i=1:size(data,1)
    for j=1:size(data,2)
   normalizeddata(i,j)=(data(i,j)-x(j))/range(j);
    end
end