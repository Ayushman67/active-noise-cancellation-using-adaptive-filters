clc
clear all;
close all;
sampling_time=1/(8*200); 
mu=0.04; 
M=16; 
Iterations=500; 
u=zeros(M,1); 
x=zeros(M,1); 
w=zeros(M,1); 
e=zeros(Iterations,1); 
Wn=[0.1 0.5]; 
[B,A]=butter(4,Wn); 
pri_n=0.5*(rand(Iterations,1)-0.5); 
ref_n=0.5*(rand(Iterations,1)-0.5); 
for n=0:Iterations-1 
t=n*sampling_time; 
for i=M:-1:2 
u(i)=u(i-1); 
end 
u(1)=0.5*(cos(2*pi*50*t)+sin(2*pi*100*t)+cos(2*pi*60*t)+sin(2*pi*80*t)+cos(2*pi*30*t)+sin(2*pi*20*t)); %rand(1); 
d(n+1)=cos(2*pi*200*n*sampling_time)+u(1)+pri_n(n+1); 
x=filter(B,A,u)+ref_n(n+1); 
d_out=conj(w')*x; 
e(n+1)=d(n+1)-d_out; 
w=w+mu*x*conj(e(n+1)); 
end
n=1:Iterations; 
subplot(3,1,1); 
plot(n,d,'g'); 
title('ANC performance-uncorrelated noise in pri and ref i/p'); 
axis([0,500,-3,3]); 
xlabel('Iterations'); 
ylabel('pri. i/p'); 
subplot(3,1,3); 
plot(n,e','b'); 
axis([0,500,-3,3]); 
xlabel('Iterations'); 
ylabel('ANC output'); 
subplot(3,1,2); 
plot(n,cos(2*pi*200*n*sampling_time)); 
ylabel('desired response'); 
xlabel('Iterations'); 
axis([0,500,-3,3]);
