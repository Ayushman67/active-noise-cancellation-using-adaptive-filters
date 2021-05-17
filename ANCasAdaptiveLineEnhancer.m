clear;
f=200;
Ts=1/(16*f);
L=1024;
for l=1:L
 t=(l-1)*Ts;
 s(l,1)=0.1*cos(2*pi*f*t);
end
N=8;
for l=1:L
 n(l,1:N)=normrnd(0,0.8,1,N);
end
mu=0.01;
M=128;
for i=1:N
 w=zeros(M,N);
 d=s+n(1:L,i);
 ref=zeros(M,1);
for l=1:L
 for k=M:-1:2
 ref(k)=ref(k-1);
 end
 ref(1)=n(l,i);
 d_out(l)=w(1:M,i)'*ref;
 e(l)=d(l)-d_out(l);
 w(1:M,i)=w(1:M,i)+2*mu*ref*conj(e(l));
 end
end
w_avg=zeros(M,1);
for i=1:N
 w_avg=w_avg+w(1:M,i);
end
w_ens=w_avg/N;
DFT=dftmtx(length(w_ens))*w_ens;
Power_spec=DFT.*conj(DFT);
plot(Power_spec);
title('ALE - Adaptive Line Enhancer');
xlabel('frequency');
ylabel('Transfer function freq. response'); 