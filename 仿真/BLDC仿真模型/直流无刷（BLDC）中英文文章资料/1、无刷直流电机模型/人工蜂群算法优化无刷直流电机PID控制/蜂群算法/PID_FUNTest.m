function ITAE= PID_FUNTest( kp,ki,kd,style)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%kp=1.4;ki=0.8;kd=0.56;
ts=0.001;
sys=tf(462,[0.78,27.2124,22.3608]);
%sys=tf(400,[1,50,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');
u_1=0.0;u_2=0.0;%u_3=0.0;
y_1=0.0;y_2=0.0;%y_3=0.0;
x=[0,0,0]';
error_1=0;
ITAE=0.0;
for k=1:1:10000
    time(k)=k*ts;
    rin(k)=1;   
    u(k)=kp*x(1)+kd*x(2)+ki*x(3);  

    yout(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;%-den(4)*y_3+num(4)*u_3;
    error(k)=rin(k)-yout(k);
  %  ITAE=ITAE+abs(error(k))*ts*k;
    
    %u_3=u_2;
    u_2=u_1;u_1=u(k);
    %y_3=y_2;
    y_2=y_1;y_1=yout(k);
    
    x(1)=error(k);
    x(2)=(error(k)-error_1)/ts;
    x(3)=x(3)+error(k)*ts;
    
    error_1=error(k);
end

    figure(1);
if style==1
    plot(time,yout,'-');
    %legend('ABC');
else if style==2
        plot(time,yout,'--');
        %legend('GA');
       % legend('ABC','GA','ACO');
    else
        plot(time,yout,'-.');
        %legend('ACO');
    end
end
hold on
%plot(iter,BestITAE,'g');
%xlabel('time(s)'),ylabel('rin,yout');
end




