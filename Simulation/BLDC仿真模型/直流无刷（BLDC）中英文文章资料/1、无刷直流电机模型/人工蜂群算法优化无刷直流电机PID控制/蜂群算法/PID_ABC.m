NP=40;%��Ⱥ���� number of population (����Ϊż��)
NS=NP/2;%��ĸ�����ȡ��Ⱥ������һ�� number of solution
D=3;%�Ż��Ĳ�����������kp,ki,kd
MaxCycle=100;%���ĵ�������
Limit=10;%��ѭ������

x=zeros(NS,D+1);%�������ÿ������Ž�
NewX=zeros(1,4);%��������������ֵ

%�趨PID�����ķ�Χ
%MaxPID=[500,700,300];
MaxPID=[20,1,1];
MinPID=[0,0,0];
%MaxKp=430;MinKp=200;MaxKi=1050;MinKi=100;MaxKd=160;MinKd=100;

for i=1:1:NS %������ʼ�⼯
    x(i,1)=round(unifrnd(MinPID(1),MaxPID(1),1,1));
    x(i,1)=x(i,1)+round(unifrnd(0,20,1,1))*0.1;
    if x(i,1)>MaxPID(1)
        x(i,1)=MaxPID(1);
    end
    x(i,2)=rand(1)*(MaxPID(2)-MinPID(2))+MinPID(2);
    x(i,3)=rand(1)*(MaxPID(3)-MinPID(3))+MinPID(3);
end
for i=1:1:NS  % ������������Ӧ��
    et=PID_FUN(x(i,1),x(i,2),x(i,3));
    x(i,4)=et;
end

BestITAE=zeros(1,100);
iter=0;
for Cycle=1:1:MaxCycle
    for s=1:1:Limit
        iter=iter+1;
        if iter>MaxCycle%������������ﵽ���ֵ�����˳�ѭ��
                break
            end
        for i=1:1:NS
            %Sort_FUN�����Ƕ��Ѳ����Ľ����ITAE��ֵ������������
            x=Sort_FUN(x,NS);%ÿ�ε�������¼��õĽ�
            BestITAE(iter)=x(1,4);
            b=x(1,4);
            if i==NS
                k=i-1;
            else
                k=i+1;
            end
            %��ʳ��Դ�����������µ�ʳ��Դ
            NewX=FindNewSolution_FUN(x(i,:),MaxPID,MinPID);
            %����ÿ��ʳ��Դ����Ӧ��,��PID������������
            NewX(1,4)=PID_FUN(NewX(1,1),NewX(1,2),NewX(1,3));
            if x(i,4)>NewX(1,4) %����ҵ���Ӧ�ȸ��õĽ�Ļ��ͽ����滻
                x(i,:)=NewX(1,:);
            end
        end %NS Cycle end
        %�����н�����õ�ǰһ��������������
        for j=1:1:NS/2
            if j==NS/2
                k=j-1;
            else
                k=j+1;
            end
            %��ʳ��Դ�����������µ�ʳ��Դ
            NewX=FindNewSolution_FUN(x(j,:),MaxPID,MinPID);
            %����ÿ��ʳ��Դ����Ӧ��,��PID������������
            NewX(1,4)=PID_FUN(NewX(1,1),NewX(1,2),NewX(1,3));
            if x(j,4)>NewX(1,4) %����ҵ���Ӧ�ȸ��õĽ�Ļ��ͽ����滻
                x(j,:)=NewX(1,:);
            end
        end
        x=Sort_FUN(x,NS);%ÿ�ε�������¼��õĽ�
        BestITAE(iter)=x(1,4);
    end %Limit Cycle end
    
    if iter>MaxCycle%������������ﵽ���ֵ�����˳�ѭ��
        break
    end
    %����һ�������󣬶�����һ���������������½�
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
xlabel('BestITAE'),ylabel('time(s��');