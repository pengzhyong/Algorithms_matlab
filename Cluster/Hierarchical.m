%%���ڲ�εľ����㷨����֮�����������ķ�
%%�ŵ㣺�㷨����ָ����֮��������������Ŀ
%%ȱ�㣺Ч�ʵͣ�ִ��ʱ�䳤
function Hierarchical         %������
clear all;clc;
centerCnt=5;
clusterCnt=30;
T=6;
clusterDistThresh=40;%���ľ�����ֵ
clusterNums=5;%����
data=genData(centerCnt,clusterCnt,T);
%plot(data(:,1),data(:,2),'bo');hold on;
for i=1:size(data,1)
    clusters.data{i}=data(i,:);%ÿһ���е�����
end
clusters.core=data;%ÿһ�������
minDist=0;
%%�ϲ���
while(minDist<(clusterDistThresh) && size(clusters.core,1)>clusterNums)
    [c1_idx,c2_idx,minDist]=closestClusterPair(clusters);
    clusters.core(c1_idx,1)=(size(clusters.data{c1_idx},1)*clusters.core(c1_idx,1)+...
                            size(clusters.data{c2_idx},1)*clusters.core(c2_idx,1))/...
                            (size(clusters.data{c1_idx},1)+size(clusters.data{c2_idx},1));
    clusters.core(c1_idx,2)=(size(clusters.data{c1_idx},1)*clusters.core(c1_idx,2)+...
                            size(clusters.data{c2_idx},1)*clusters.core(c2_idx,2))/...
                            (size(clusters.data{c1_idx},1)+ size(clusters.data{c2_idx},1));      
    clusters.data{c1_idx}=[clusters.data{c1_idx};clusters.data{c2_idx}];
    if(c2_idx~=size(clusters.data,2))
        clusters.data={clusters.data{1:c2_idx-1},clusters.data{c2_idx+1:end}};
        clusters.core=[clusters.core(1:c2_idx-1,:);clusters.core(c2_idx+1:end,:)];
    else
        clusters.data=clusters.data(1:c2_idx-1);
        clusters.core=clusters.core(1:c2_idx-1,:);
    end
    %��̬��ʾ������̣��������϶�ʱ��ǰ�ڻ������䣬������ܿ�������Ч��
    plot(data(:,1),data(:,2),'bo');
    for i=1:size(clusters.core,1)
        for j=1:size(clusters.data{i},1)
            line([clusters.core(i,1),clusters.data{i}(j,1)],[clusters.core(i,2),clusters.data{i}(j,2)]);
        end
    end
   pause(0.001);
end
plot(data(:,1),data(:,2),'bo');
for i=1:size(clusters.core,1)
    for j=1:size(clusters.data{i},1)
        line([clusters.core(i,1),clusters.data{i}(j,1)],[clusters.core(i,2),clusters.data{i}(j,2)]);
    end
end

%%��������
function data=genData(centerCnt,clusterCnt,T)
%centerCnt: center numbers, class numbers
%clusterCnt: numbers of points per class
%T: the sigma of normal random numbers
data=[];
for i=1:centerCnt
    newdata=[ceil(randi(100,1,1)+T.*randn(clusterCnt,1)),ceil(randi(100,1,1)+T.*randn(clusterCnt,1))];
    data=[data;newdata];
end
%%�����
function distance=dist(point1,point2)
distance=sqrt((point1(1,1)-point2(1,1))^2+(point1(1,2)-point2(1,2))^2);
%�ҳ���С�����һ����
function [point1Idx,point2Idx,minDist]=closestClusterPair(clusters)
point1Idx=1;
point2Idx=2;
minDist=dist([clusters.core(1,1),clusters.core(1,2)],[clusters.core(2,1),clusters.core(2,2)]);
for i=1:size(clusters.core,1)
    for j=1:size(clusters.core,1)
        if(i==j)
            break;
        end
        dist_ij=dist([clusters.core(i,1),clusters.core(i,2)],[clusters.core(j,1),clusters.core(j,2)]);
        if(dist_ij<minDist)
            minDist=dist_ij;
            point1Idx=i;
            point2Idx=j;
        end
    end
end
if(point1Idx>point2Idx)
    temp=point1Idx;
    point1Idx=point2Idx;
    point2Idx=temp;
end