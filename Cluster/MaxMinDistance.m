%%最大最小距离聚类算法
clear all;clc;
centerCnt=5;
clusterCnt=50;
T=10;
data=genData(centerCnt,clusterCnt,T);
figure
plot(data(:,1),data(:,2),'bo');hold on;
sita=0.5;%距离阈值
initIdx=randi(size(data,1));
clusters=[data(initIdx,1),data(initIdx,2)];

%%确定初始的两个类中心
wholeMax=0;
wholeMaxIdx=1;
for i=1:size(data,1)
    minDist=sqrt((data(i,1)-clusters(1,1))^2+((data(i,2)-clusters(1,2))^2));
    for j=1:size(clusters,1)
        distance=sqrt((data(i,1)-clusters(j,1))^2+((data(i,2)-clusters(j,2))^2));
        if(distance<minDist)
            minDist=distance;
        end
    end
    if(minDist>wholeMax)
        wholeMax=minDist;
        wholeMaxIdx=i;
    end
end
clusters=[clusters;[data(wholeMaxIdx,1),data(wholeMaxIdx,2)]];
Dist12=sqrt((clusters(1,1)-clusters(2,1))^2+((clusters(1,2)-clusters(2,2))^2));%z1与z2之间的距离

%%确定其余的聚类中心
while(1)
    wholeMax=0;
    wholeMaxIdx=1;
    for i=1:size(data,1)
        minDist=sqrt((data(i,1)-clusters(1,1))^2+((data(i,2)-clusters(1,2))^2));
        for j=1:size(clusters,1)
            distance=sqrt((data(i,1)-clusters(j,1))^2+((data(i,2)-clusters(j,2))^2));
            if(distance<minDist)
                minDist=distance;
            end
        end
        if(minDist>wholeMax)
            wholeMax=minDist;
            wholeMaxIdx=i;
        end
    end 
    if(wholeMax>sita*Dist12)
        clusters=[clusters;[data(wholeMaxIdx,1),data(wholeMaxIdx,2)]];
        continue;
    end
    break;
end

%%对点进行分类
pointCenter=ones(size(data,1),1);
for i=1:size(data,1)
    minDist=sqrt((data(i,1)-clusters(1,1))^2+((data(i,2)-clusters(1,2))^2));
    for j=1:size(clusters,1)
        distance=sqrt((data(i,1)-clusters(j,1))^2+((data(i,2)-clusters(j,2))^2));
        if(distance<minDist)
            minDist=distance;
            pointCenter(i)=j;
        end
    end
    line([data(i,1),clusters(pointCenter(i),1)],[data(i,2),clusters(pointCenter(i),2)]);
end







