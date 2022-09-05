function  IterBestJ( BestITAE,CycleTimes,style)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:1:CycleTimes
    iter(i)=i;
end
%plot(time,rin,'b',time,yout,'r')
figure(2)
if style==1
    plot(iter,BestITAE,'-');
    %legend('ABC');
else if style==2
        plot(iter,BestITAE,'--');
     %   legend('GA');
    else
        plot(iter,BestITAE,'-.');
      %  legend('ACO');
    end
end
xlabel('IterNum'),ylabel('BestJ');
hold on
end

