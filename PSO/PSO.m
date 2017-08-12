%%a simple example of PSO
%find the max value of a function
%2017/8/4,by kk
x=-10:0.1:10;
y=x+10*sin(5*x)+7*cos(4*x);
plot(x,y);hold on;
popsize=30;
ite=10;
position=rand(popsize,1);
position=position*20-ones(popsize,1)*10;
posMax=10;posMin=-10;vMax=1;vMin=-1;
velosity=2*rand(popsize,1)-1;
pbest=position;gbest=position(1);
wBegin=1;wEnd=0.05;c1=2;c2=2;
for i=1:ite
    position_new=position+velosity;
    velosity_new=(wEnd+(wBegin-wEnd)*(100-i)/100).*velosity+c1*rand().*(position-pbest.*ones(popsize,1))+c2*rand().*(position-gbest.*ones(popsize,1));
    for j=1:popsize
        if(position_new(j)>posMax)
            position_new(j)=posMax;
        end
        if(position_new(j)<posMin)
            position_new(j)=posMin;
        end
        if(velosity_new(j)>vMax)
            velosity_new(j)=vMax;
        end
        if(velosity_new(j)<vMin)
            velosity_new(j)=vMin;
        end
         if(fun(position_new(j))>fun(pbest(j)))
            pbest(j)=position_new(j);
        end
        if(fun(position_new(j))>fun(gbest))
            gbest=position_new(j);
        end
    end
    position=position_new;
    velosity=velosity_new;
end
plot(gbest,fun(gbest),'or');







