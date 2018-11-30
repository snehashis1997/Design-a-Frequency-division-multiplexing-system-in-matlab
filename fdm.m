fs=2000;
fm1=4;
fm2=5;
fm3=6;
fcm1=25;
fcm2=50;
fcm3=75;

tiv=1/fs;
t=0:tiv:1;
A=2;
mu=0;
sigma=10;
m1=A*cos(2*pi*fm1*t);
sound(m1,fs);
pause(5);
len=length(m1);
y=lognpdf(mu,sigma);
m1=m1+y';

m2=2*A*cos(2*pi*fm2*t);
m3=3*A*cos(2*pi*fm3*t);

c1=A*cos(2*pi*fcm1*t);
c2=A*cos(2*pi*fcm2*t);
c3=A*cos(2*pi*fcm3*t);

x=m1.*c1+m2.*c2+m3.*c3;
x=awgn(x,.02);%adding awgn in channel

[num1,den1]=butter(5,[.5*(fcm1-fm1),fcm1+fm1]*4/fs);
[num2,den2]=butter(5,[.5*(fcm2-fm2),fcm2+fm2]*4/fs);
[num3,den3]=butter(5,[.5*(fcm3-fm3),fcm3+fm3]*4/fs);


filtr1=filter(num1,den1,x);
filtr2=filter(num2,den2,x);
filtr3=filter(num3,den3,x);

lp1=filtr1.*c1;
lp2=filtr2.*c2;
lp3=filtr3.*c3;

[num11,den11]=butter(5,4*fm1/fs);
[num22,den22]=butter(5,4*fm2/fs);
[num33,den33]=butter(5,4*fm3/fs);

lpf_out1=filter(num11,den11,lp1);
lpf_out2=filter(num22,den22,lp2);
lpf_out3=filter(num33,den33,lp3);

subplot(3,3,1);
plot(t,m1);
title('messege signal 1');
grid on;

subplot(3,3,2);
plot(t,m2);title('messege signal 2');
grid on;

subplot(3,3,3);
plot(t,m3);title('messege signal 3');
grid on;

subplot(3,3,4);
plot(t,c1);title('carrier signal 1');
grid on;

subplot(3,3,5);
plot(t,c2);title('carrier signal 2');
grid on;

subplot(3,3,6);
plot(t,c3);title('carrier signal 3');
grid on;

subplot(3,3,7);
plot(t,lpf_out1);title('filter1 output');
grid on;

subplot(3,3,8);
plot(t,lpf_out2);title('filter2 output');
grid on;

subplot(3,3,9);
plot(t,lpf_out3);title('filter3 output');
grid on;

sound(m1,fs);
pause(2);
sound(lpf_out1,fs);



