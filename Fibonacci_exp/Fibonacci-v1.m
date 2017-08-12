%%Fibonacci variant sequence, mature in m-1 months, converge to 0.724
format long;
m=3;
g(1,1)=1;
for k=0:m
   g(1,m)=0;
end
y(1)=1;
for i=2:60
    g(i,1)=g(i-1,m);
    for k=2:m-1
        g(i,k)=g(i-1,m-1);
    end
    g(i,m)=g(i-1,m-1)+g(i-1,m);
    temp1=0;
    temp2=0;
    for k=1:m
       temp1=temp1+g(i-1,m); 
       temp2=temp2+g(i,m); 
    end
    y(i-1)=temp1;
    y(i)=temp2;
    rate(i-1)=y(i-1)/y(i);
end
x=1:60;
xx=1:59;
plot(xx,rate)