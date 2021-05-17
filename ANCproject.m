clc;
clear all;
close all;

load('desnoi');
x2=x2(:); 
s2=s2(:); 
a = input('enter a value');              %initializing the values of a and c for step size
c = input('enter c value');
L = 512;
 N=length(x2); 
 xin=zeros(L,1);
 w=zeros(L,1); 

%initialization of variables
y = 0*x2;
e = 0*x2;
powerS = 0*x2;
powerE = 0*x2;
%NLMS algorithm
for i=1:N
xin = [x2(i); xin(1:end-1)];
y(i)=w'*xin; 
error=s2(i)-y(i);                        %ERROR
e(i)=error;                             %Store estimation error                       
mu=a/(c+xin'*xin);                      %Calculate Step-size
wtemp = w + 2*mu*error*xin;             %Update filter
w = wtemp;
powerS(i) = abs(s2(i))^2;                %Power of Microphone signal
powerE(i)=abs(e(i))^2;                  %power of Error signal

end
%LMS algorithm
for i=1:N
xin = [x2(i); xin(1:end-1)];
y1(i)=w'*xin; 
error1=s2(i)-y1(i);                        %ERROR
e1(i)=error1;                             %Store estimation error                       
mu=0.01;                      %Calculate Step-size
wtemp = w + 2*mu*error1*xin;             %Update filter
w = wtemp;
powerS1(i) = abs(s2(i))^2;                %Power of Microphone signal
powerE1(i)=abs(e1(i))^2;                  %power of Error signal

end
%VL-LMS algorithm
for i=1:N
xin = [x2(i); xin(1:end-1)];
y2(i)=w'*xin; 
error2=s2(i)-y2(i);                        %ERROR
e2(i)=error2;                             %Store estimation error                       
mu=0.01;                      %Calculate Step-size
gamma=0.05;
wtemp = (1-2*mu*gamma)*w + 2*mu*error2*xin;             %Update filter
w = wtemp;
powerS2(i) = abs(s2(i))^2;                %Power of Microphone signal
powerE2(i)=abs(e2(i))^2;                  %power of Error signal

end


for i=1:N-L
 %Echo Return Loss Enhancement
 ERLE(i)=10*log10(mean(powerS(i:i+L))/mean(powerE(i:i+L)));     %Calculating the ERLE
 ERLE1(i)=10*log10(mean(powerS1(i:i+L))/mean(powerE1(i:i+L)));     %Calculating the ERLE
 ERLE2(i)=10*log10(mean(powerS2(i:i+L))/mean(powerE2(i:i+L)));     %Calculating the ERLE
 
end


%-------Echo signal--------
figure
subplot(4,1,1)

plot(s2)                                       %plotting the echo signal
xlabel('time (samples)','FontSize', 18);
ylabel('echo(n)','FontSize', 18);
title('ECHO SIGNAL: echo(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Input signal-------------------
subplot(4,1,2)
% figure*
plot(x2)                                                %plotting the input signal
xlabel('time (samples)','FontSize', 18);
ylabel('x(n)','FontSize', 18);
title('INPUT SIGNAL: x(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Output signal x(n)----------------
subplot(4,1,3)
% figure
plot(y)                                                %plotting output signal
xlabel('time (samples)','FontSize', 18);
ylabel('y(n)','FontSize', 18);
title('OUTPUT SIGNAL y(n) for NLMS','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Error signal x(n)-----------------
subplot(4,1,4)
% figure
plot(e,'red')                                         %plotting the error signal
xlabel('time (samples)','FontSize', 18);
ylabel('E(n)','FontSize', 18);
title('ERROR SIGNAL: e(n) for NLMS','FontSize', 18)
axis([0 N -1 1]);
grid on

%ERLE calculation
% ylabel('Desired signal/Error signal (dB)','FontSize', 20);
figure
subplot(311)
plot(ERLE)
hold on;                                            %plotting the ERLE w.r.t desired signal
plot(s2,'r');                        
xlabel('Sample number (n)','FontSize', 20);
% ylabel('Desired signal/Error signal (dB)','FontSize', 20);
legend('ERLE', 'DESIRED SIGNAL')
title('ECHO RETURN LOSS ENHANCEMENT for NLMS','FontSize', 20)
axis([0 N -20 40]);
grid on 

subplot(312)
plot(ERLE1)
hold on;                                            %plotting the ERLE w.r.t desired signal
plot(s2,'r');                        
 xlabel('Sample number (n)','FontSize', 20);
% ylabel('Desired signal/Error signal (dB)','FontSize', 20);
legend('ERLE', 'DESIRED SIGNAL')
title('ECHO RETURN LOSS ENHANCEMENT for LMS','FontSize', 20)
axis([0 N -20 40]);
grid on 

subplot(313)
plot(ERLE2)
hold on;                                            %plotting the ERLE w.r.t desired signal
plot(s2,'r');                        
xlabel('Sample number (n)','FontSize', 20);
% ylabel('Desired signal/Error signal (dB)','FontSize', 20);
legend('ERLE', 'DESIRED SIGNAL')
title('ECHO RETURN LOSS ENHANCEMENT for LLMS','FontSize', 20)
axis([0 N -20 40]);
grid on 
%LMS algorithm

figure
subplot(4,1,1)

plot(s2)                                       %plotting the echo signal
xlabel('time (samples)','FontSize', 18);
ylabel('echo(n)','FontSize', 18);
title('ECHO SIGNAL: echo(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Input signal-------------------
subplot(4,1,2)
% figure*
plot(x2)                                                %plotting the input signal
xlabel('time (samples)','FontSize', 18);
ylabel('x(n)','FontSize', 18);
title('INPUT SIGNAL: x(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

% figure
subplot(4,1,3)
plot(y1)                                                %plotting output signal
xlabel('time (samples)','FontSize', 18);
ylabel('y(n)','FontSize', 18);
title('OUTPUT SIGNAL y(n) for LMS','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Error signal x(n)-----------------
subplot(4,1,4)
% figure
plot(e1,'red')                                         %plotting the error signal
xlabel('time (samples)','FontSize', 18);
ylabel('E(n)','FontSize', 18);
title('ERROR SIGNAL: e(n) for LMS','FontSize', 18)
axis([0 N -1 1]);
grid on
% LLMS agorithm

figure
subplot(4,1,1)

plot(s2)                                       %plotting the echo signal
xlabel('time (samples)','FontSize', 18);
ylabel('echo(n)','FontSize', 18);
title('ECHO SIGNAL: echo(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Input signal-------------------
subplot(4,1,2)
% figure*
plot(x2)                                                %plotting the input signal
xlabel('time (samples)','FontSize', 18);
ylabel('x(n)','FontSize', 18);
title('INPUT SIGNAL: x(n)','FontSize', 18)
grid on
axis([0 N -1 1]);

% figure
subplot(413)
plot(y2)                                                %plotting output signal
xlabel('time (samples)','FontSize', 18);
ylabel('y(n)','FontSize', 18);
title('OUTPUT SIGNAL y(n) for LLMS','FontSize', 18)
grid on
axis([0 N -1 1]);

%-------Error signal x(n)-----------------
subplot(4,1,4)
% figure
plot(e2,'red')                                         %plotting the error signal
xlabel('time (samples)','FontSize', 18);
ylabel('E(n)','FontSize', 18);
title('ERROR SIGNAL: e(n) for LLMS','FontSize', 18)
axis([0 N -1 1]);
grid on
