clear;
N=1024;
mu=0.01; %change mu=0.001 and see the result-mmse vs. speed of adaptation
ws=200;
Ts=1/(4*ws);
%drift=1.2; %constant bias;
w(1)=0;
for n=1:N
 t=(n-1)*Ts;
 s(n)=cos(ws*t);
 drift(n)=(-1+exp(0.0008*n));
 d(n)=s(n)+drift(n);
 drift_=w(n);
 s_(n)=d(n)-drift_;
 e(n)=s_(n);
 w(n+1)=w(n)+2*mu*e(n);
end
subplot(2,1,1);
plot(d);
title('Bias/Drift removal using ANC');
ylabel('i/p signal');
xlabel('Iterations');
axis([0 N -2 2]);
subplot(2,1,2);
plot(s_);
ylabel('ANC o/p');
xlabel('Iterations');
axis([0 N -2 2]); 