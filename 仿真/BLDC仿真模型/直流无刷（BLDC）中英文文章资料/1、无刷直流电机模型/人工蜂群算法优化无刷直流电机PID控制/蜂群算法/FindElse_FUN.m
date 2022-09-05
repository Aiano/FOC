function [NewX] = FindElse_FUN(xi,xk,MaxPID,MinPID)
%在xi的邻域搜索新解
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
NewX=zeros(1,4);

%NewX(1,1)=xi(1,1)+(1-round(unifrnd(0,2,1,1)))*(MaxPID(1,1)-MinPID(1,1));
%NewX(1,1)=xi(1,1)+(1-round(unifrnd(0,2,1,1)))*(xi(1,1)-xk(1,1));
NewX(1,1)=xi(1,1)+rand(1)*(xi(1,1)-xk(1,1));
%NewX(1,2)=xi(1,2)+(1-round(unifrnd(0,2,1,1)))*(MaxPID(1,2)-MinPID(1,2));
%NewX(1,2)=xi(1,2)+(1-round(unifrnd(0,2,1,1)))*(xi(1,2)-xk(1,2));
NewX(1,2)=xi(1,2)+rand(1)*(xi(1,2)-xk(1,2));
%NewX(1,3)=xi(1,3)+(1-round(unifrnd(0,2,1,1)))*(MaxPID(1,3)-MinPID(1,3));
%NewX(1,3)=xi(1,3)+(1-round(unifrnd(0,2,1,1)))*(xi(1,3)-xk(1,3));
NewX(1,3)=xi(1,3)+rand(1)*(xi(1,3)-xk(1,3));
for i=1:1:3
    if NewX(1,i)>MaxPID(i)
        NewX(1,i)=MaxPID(i);
    else if NewX(1,i)<MinPID(i)
            NewX(1,i)=MinPID(i);
        end
    end
end
end

