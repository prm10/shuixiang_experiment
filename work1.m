clc;close all;clear all;
%% ϵͳ�Ĺ��ɹ���ʱ��
u_M=zeros(1,1000);
u_M(1,2:1000)=1;
deltaT=0.1;
lamda=0.;
[z0,t0,z_k0,k0]= Model2010011452(u_M,deltaT,lamda);
%% ����M���У��õ����
a=1;Np=63;deltaT=1;
connections=[1 1 0 0 1 1];%��������ʽ(6,5,2,1,0)
registers=[0 0 0 0 0 1];%��ʼֵ
len=Np*4;
[u_M]=mseq(connections,registers,len,a);
%% �ڲ�ͬ�����űȵ������¸���4.2��4.3�Ľ��
lumpda=0;
[z z_k g1 g_k1]=xgfxf(u_M,deltaT,lumpda,Np,a);%��ط�����
delta1=std(z);delta2=std(z_k);
lumpda=0.005;
[z z_k g2 g_k2]=xgfxf(u_M,deltaT,lumpda,Np,a);
lumpda=0.02;
[z z_k g3 g_k3]=xgfxf(u_M,deltaT,lumpda,Np,a);
lumpda=0.05;
[z z_k g4 g_k4]=xgfxf(u_M,deltaT,lumpda,Np,a);
%% ��������ͼ
close all;
figure,plot([0 100],[2*0.97 2*0.97],'-.',t0,z0,'-',k0,z_k0,'-.');
xlabel('ʱ��t/s');axis([0 100 0 2.5]);title('ϵͳ�Ĺ��ɹ���ʱ��');
plotresult(0,deltaT,Np,g1,g_k1,delta1,delta2)
plotresult(0.005,deltaT,Np,g2,g_k2,delta1,delta2)
plotresult(0.02,deltaT,Np,g3,g_k3,delta1,delta2)
plotresult(0.05,deltaT,Np,g4,g_k4,delta1,delta2)