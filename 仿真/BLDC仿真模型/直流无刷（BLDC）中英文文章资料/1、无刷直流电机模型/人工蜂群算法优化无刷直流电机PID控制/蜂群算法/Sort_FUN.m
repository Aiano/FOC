function [x] = Sort_FUN( x ,NS)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Ã°ÅÝÅÅÐò
sortx=zeros(1,4);
for i=1:1:NS
    for j=1:1:NS-i
        if x(j,4)>x(j+1,4)
            sortx(1,:)=x(j,:);
            x(j,:)=x(j+1,:);
            x(j+1,:)=sortx(1,:);
        end
    end
end
x;
end

