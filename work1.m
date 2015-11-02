clc;close all;clear all;
%% 系统的过渡过程时间
u_M=zeros(1,1000);
u_M(1,2:1000)=1;
deltaT=0.1;
lamda=0.;
[z0,t0,z_k0,k0]= Model2010011452(u_M,deltaT,lamda);
%% 输入M序列，得到输出
a=1;Np=63;deltaT=1;
connections=[1 1 0 0 1 1];%特征多项式(6,5,2,1,0)
registers=[0 0 0 0 0 1];%初始值
len=Np*4;
[u_M]=mseq(connections,registers,len,a);
%% 在不同的噪信比的条件下给出4.2和4.3的结果
lumpda=0;
[z z_k g1 g_k1]=xgfxf(u_M,deltaT,lumpda,Np,a);%相关分析法
delta1=std(z);delta2=std(z_k);
lumpda=0.005;
[z z_k g2 g_k2]=xgfxf(u_M,deltaT,lumpda,Np,a);
lumpda=0.02;
[z z_k g3 g_k3]=xgfxf(u_M,deltaT,lumpda,Np,a);
lumpda=0.05;
[z z_k g4 g_k4]=xgfxf(u_M,deltaT,lumpda,Np,a);
%% 画出所有图
close all;
figure,plot([0 100],[2*0.97 2*0.97],'-.',t0,z0,'-',k0,z_k0,'-.');
xlabel('时间t/s');axis([0 100 0 2.5]);title('系统的过渡过程时间');
plotresult(0,deltaT,Np,g1,g_k1,delta1,delta2)
plotresult(0.005,deltaT,Np,g2,g_k2,delta1,delta2)
plotresult(0.02,deltaT,Np,g3,g_k3,delta1,delta2)
plotresult(0.05,deltaT,Np,g4,g_k4,delta1,delta2)