clear all;
close all;
clc;
tic
% Storing data of the test signal in double-precision array 
[desired,Fs] = audioread('near_end.wav');% Loading of test signal
desired = desired / rms(desired, 1);%Normalization of the signal

m = length(desired);
t=(1:m)';

%Reference signal u(k)
%refer = wgn(m,1,-10); % Addition of noise directly in MATLAB
%refer = wgn(m,1,-5);
%refer = wgn(m,1,0);
%refer = wgn(m,1,5);
refer = wgn(m,1,10);

fil = fir1(11, 0.4);% Designing a FIR filter
u = filter(fil, 1, refer);%Filtering the reference signal

%Primary signal s(k)+n(k) 
primary = desired+ u;

%Calculation of LMS filter weights
order = 11;
mu = 0.003642;
n = length(primary);
w = zeros(order,1);
E = zeros(1,m);
for k = 11:n
 U = u(k-10:k);
 y = U'*w;
 E(k) = primary(k)-y;
 w = w + mu*E(k)*U;
end

%Plotting of the signals
T=(1:m)';
figure(1);
subplot(4,1,1);
plot(t,desired);
title('Desired Signal in time domain'); 
xlabel('Time');
ylabel('desired signal');

subplot(4,1,2);
plot(t,u);
title('Reference Signal in time domain'); 
xlabel('Time');
ylabel('Reference signal'); 

subplot(4,1,3);
plot(t,primary);
xlabel('Time');
ylabel('primary signal');
title('Primary Signal in time domain');

subplot(4,1,4);
plot(T,E);
xlabel('Time');
ylabel('Denoised Signal');
title('Denoised signal in time domain');

figure(2);
freqz(desired);
title('Desired Signal in frequency domain');

figure(3);
freqz(u);
title('Reference Signal in frequency domain'); 

figure(4);
freqz(primary);
title('Primary Signal in frequency domain');

figure(5);
freqz(E);
title('Denoised signal in frequency domain');
%Signal to noise ratio(SNR) and varience of desired signal and denoised signal(E)
disp(snr(desired));%Signal to noise ratio of the desired signal 
disp(var(desired));%Varience of the desired signal 
disp(snr(E));%Signal to noise ratio of the output signal E
disp(var(E));%Varience of the output signal E
toc;
