x=1:20;
y(1)=0.5;
for i=2:20
    y(i)=Fibonacci_general(i,500);
end
plot(x,y,'r*-.');