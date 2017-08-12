%%Fibonacci variant sequence, mature in 5 months, converge to 0.755
format long;
g(1,1)=1;
g(1,2)=0;
g(1,3)=0;
g(1,4)=0;
g(1,5)=0;
y(1)=1;
for i=2:60
    g(i,1)=g(i-1,5);
    g(i,2)=g(i-1,1);
    g(i,3)=g(i-1,2);
    g(i,4)=g(i-1,3);
    g(i,5)=g(i-1,4)+g(i-1,5);
    y(i-1)=g(i-1,1)+g(i-1,2)+g(i-1,3)+g(i-1,4)+g(i-1,5);
    y(i)=g(i,1)+g(i,2)+g(i,3)+g(i,4)+g(i,5);
    rate(i-1)=y(i-1)/y(i);
end
x=1:60;
xx=1:59;
plot(xx,rate)