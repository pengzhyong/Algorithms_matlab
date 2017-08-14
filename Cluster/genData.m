%%generate data for algrithm
function data=genData(centerCnt,clusterCnt,T)

%centerCnt: center numbers, class numbers
%lcusterCnt: numbers of points per class
%T: the sigma of normal random numbers
data=[];
for i=1:centerCnt
    newdata=[ceil(randi(300,1,1)+T.*randn(clusterCnt,1)),ceil(randi(300,1,1)+T.*randn(clusterCnt,1))];
    data=[data;newdata];
end
