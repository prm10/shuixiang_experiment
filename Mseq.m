clear all;close all;clc
L=60;
u_M=zeros(L,1);  %周期是15
u_M(1)=1;
u_M(2)=0;
u_M(3)=0;
u_M(4)=0;

for i=4:L
    u_M(i)=mod(u_M(i-1)+u_M(i-3),2);
end
u_M=-1*sign(u_M-0.5);
a_M=1;            %M序列的幅度
u_M=a_M*u_M;
Np_M=63;          %M序列的周期
