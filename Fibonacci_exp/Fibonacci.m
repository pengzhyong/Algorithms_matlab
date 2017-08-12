%%Fibonacci sequence 
%%斐波那契数列源于兔子问题，兔子生下来第二个月成熟且繁殖下一代，
%%假设兔子在第m个月成熟，可以得到数列中相邻两个值的比值与m之间的关系
format long;
g(1,1)=1;
g(1,2)=0;
y(1)=1;
for i=2:20
    g(i,1)=g(i-1,2);
    g(i,2)=g(i-1,1)+g(i-1,2);
    y(i-1)=g(i-1,1)+g(i-1,2);
    y(i)=g(i,1)+g(i,2);
    rate(i-1)=y(i-1)/y(i);
end
x=1:20;
xx=1:19;
plot(xx,rate)