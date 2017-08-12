%%基于最近邻规则的试探法
clear all;clc;
centerCnt=5;
clusterCnt=50;
T=10;
data=genData(centerCnt,clusterCnt,T);
dT=50;
points.pos=data;
points.status=zeros(size(data,1),1);
centers=[points.pos(1,1),points.pos(1,2)];%initial a cluster center
points.status(1)=1;

mindistCent=0;
for i=1:size(points.pos,1)
    if(points.status(i)~=0)
        continue;
    end
    mindist=dT;
    for j=1:size(centers,1)
       distance=sqrt((points.pos(i,1)-centers(j,1))^2+((points.pos(i,2)-centers(j,2))^2));
       if(distance<mindist)
           mindist=distance;
           mindistCent=j;
       end           
    end
     if(mindist<dT)
           points.status(i)=mindistCent;
     else
         centers=[centers;[points.pos(i,1),points.pos(i,2)]];
         points.status(i)=size(centers,1);
     end
end

%%二次聚类
for i=1:size(points.pos,1)
   distance=sqrt((points.pos(i,1)-centers(points.status(i),1))^2+(points.pos(i,2)-centers(points.status(i),2))^2);
    for j=1:size(centers,1)
       dist1=sqrt((points.pos(i,1)-centers(j,1))^2+(points.pos(i,2)-centers(j,2))^2);
       if(dist1<distance)
           distance=dist1;
           points.status(i)=j;
       end           
    end
end
for i=1:size(points.pos,1)
    line([points.pos(i,1),centers(points.status(i),1)],[points.pos(i,2),centers(points.status(i),2)]);
end

