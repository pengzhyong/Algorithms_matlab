%%基于最近邻规则的试探法
%clear all;clc;
centerCnt=5;
clusterCnt=50;
T=5;
data=genData(centerCnt,clusterCnt,T);
figure
plot(data(:,1),data(:,2),'bo');hold on;
dT=50;
points.pos=data;
points.clusteCenterIdx=zeros(size(data,1),1);
centers=[points.pos(1,1),points.pos(1,2)];%initial a cluster center
points.clusteCenterIdx(1)=1;

%%首次聚类确定类中心点
mindistCent=0;
for i=1:size(points.pos,1)
    if(points.clusteCenterIdx(i)~=0)
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
           points.clusteCenterIdx(i)=mindistCent;
     else
         centers=[centers;[points.pos(i,1),points.pos(i,2)]];
         points.clusteCenterIdx(i)=size(centers,1);
     end
end

%%二次聚类，纠正第一次聚类中错误的分类
for i=1:size(points.pos,1)
   distance=sqrt((points.pos(i,1)-centers(points.clusteCenterIdx(i),1))^2+(points.pos(i,2)-centers(points.clusteCenterIdx(i),2))^2);
    for j=1:size(centers,1)
       dist1=sqrt((points.pos(i,1)-centers(j,1))^2+(points.pos(i,2)-centers(j,2))^2);
       if(dist1<distance)
           distance=dist1;
           points.clusteCenterIdx(i)=j;
       end           
    end
end
for i=1:size(points.pos,1)
    line([points.pos(i,1),centers(points.clusteCenterIdx(i),1)],[points.pos(i,2),centers(points.clusteCenterIdx(i),2)]);
end

