NP=40;%种群个数 number of population (必需为偶数)
NS=NP/2;%解的个数，取种群个数的一半 number of solution
D=3;%优化的参数个数，即kp,ki,kd
MaxCycle=100;%最大的迭代次数
Limit=10;%内循环次数

x=zeros(NS,D+1);%用来存放每个相对优解
NewX=zeros(1,4);%用来保存邻域新值

%设定PID参数的范围
%MaxPID=[500,700,300];
MaxPID=[20,1,1];
MinPID=[0,0,0];
%MaxKp=430;MinKp=200;MaxKi=1050;MinKi=100;MaxKd=160;MinKd=100;

for i=1:1:NS %产生初始解集
    x(i,1)=round(unifrnd(MinPID(1),MaxPID(1),1,1));
    x(i,1)=x(i,1)+round(unifrnd(0,20,1,1))*0.1;
    if x(i,1)>MaxPID(1)
        x(i,1)=MaxPID(1);
    end
    x(i,2)=rand(1)*(MaxPID(2)-MinPID(2))+MinPID(2);
    x(i,3)=rand(1)*(MaxPID(3)-MinPID(3))+MinPID(3);
end
for i=1:1:NS  % 计算各个解的适应度
    et=PID_FUN(x(i,1),x(i,2),x(i,3));
    x(i,4)=et;
end

BestITAE=zeros(1,100);
iter=0;
for Cycle=1:1:MaxCycle
    for s=1:1:Limit
        iter=iter+1;
        if iter>MaxCycle%如果迭代次数达到最大值，即退出循环
                break
            end
        for i=1:1:NS
            %Sort_FUN函数是对已产生的解根据ITAE的值进行升序排序
            x=Sort_FUN(x,NS);%每次迭代都记录最好的解
            BestITAE(iter)=x(1,4);
            b=x(1,4);
            if i==NS
                k=i-1;
            else
                k=i+1;
            end
            %在食物源的邻域搜索新的食物源
            NewX=FindNewSolution_FUN(x(i,:),MaxPID,MinPID);
            %计算每个食物源的适应度,即PID参数的优劣性
            NewX(1,4)=PID_FUN(NewX(1,1),NewX(1,2),NewX(1,3));
            if x(i,4)>NewX(1,4) %如果找到适应度更好的解的话就进行替换
                x(i,:)=NewX(1,:);
            end
        end %NS Cycle end
        %对所有解中最好的前一半解进行邻域搜索
        for j=1:1:NS/2
            if j==NS/2
                k=j-1;
            else
                k=j+1;
            end
            %在食物源的邻域搜索新的食物源
            NewX=FindNewSolution_FUN(x(j,:),MaxPID,MinPID);
            %计算每个食物源的适应度,即PID参数的优劣性
            NewX(1,4)=PID_FUN(NewX(1,1),NewX(1,2),NewX(1,3));
            if x(j,4)>NewX(1,4) %如果找到适应度更好的解的话就进行替换
                x(j,:)=NewX(1,:);
            end
        end
        x=Sort_FUN(x,NS);%每次迭代都记录最好的解
        BestITAE(iter)=x(1,4);
    end %Limit Cycle end
    
    if iter>MaxCycle%如果迭代次数达到最大值，即退出循环
        break
    end
    %经过一轮搜索后，对最差的一半解进行重新搜索新解
    for worse=NS/2:1:NS
        NewX=FindElse_FUN(x(1,:),x(NS,:),MaxPID,MinPID);
        NewX(1,4)=PID_FUN(NewX(1,1),NewX(1,2),NewX(1,3));
        if x(worse,4)>NewX(1,4)
            x(worse,:)=NewX(1,:);
        end
    end
end % MaxCycle Cycle end
NewX(1,:)=x(1,:);
for i=2:1:NS
    if x(i,4)<NewX(1,4)
        NewX(1,:)=x(i,:);
    end
end
NewX(1,:)
BestITAE
PID_FUNTest(NewX(1,1),NewX(1,2),NewX(1,3),1);
for i=1:1:100
    j=i;
    BestJ(j)=BestITAE(j);
end
IterBestJ(BestJ,100,1);
plot(BestITAE,time);
xlabel('BestITAE'),ylabel('time(s）');