clc;close all;clear all;
%% ����M���У��õ����
a=1;Np=2^8-1;
connections=[1 1 0 0 0 0 1 1];%��������ʽ(8,7,2,1,0)
registers=[0 0 0 0 0 0 0 1];%��ʼֵ
len=Np*2;
[u_M]=mseq(connections,registers,len,a);
%% ������ʶ
lamda=0.00004;
z=Model2010011452(u_M,lamda);
[J_L1 N1 theta1 t1 z_p]=Ls(u_M,z,Np,10,0);%������С���ˣ�LS��
[J_L2 N2 theta2 t2 theta]=RLS(u_M,z,Np,10,0);%������С���ˣ�RLS��
plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% ��ͼ
%% ��������ָ��
lamda=0.01;
z=Model2010011452(u_M,lamda);
[J_L1 N11 theta11 t11 z_p]=Ls(u_M,z,Np,10,2);%������С���ˣ�LS��
[J_L2 N21 theta21 t21 theta]=RLS(u_M,z,Np,10,2);%������С���ˣ�RLS��
plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% ��ͼ
yita(1)=lamda/std(z);
delta(1,:)=zhibiao(theta1,theta11,N1);
delta(2,:)=zhibiao(theta1,theta21,N1);

lamda=0.04;
z=Model2010011452(u_M,lamda);
[J_L1 N12 theta12 t12 z_p]=Ls(u_M,z,Np,10,2);%������С���ˣ�LS��
[J_L2 N22 theta22 t22 theta]=RLS(u_M,z,Np,10,2);%������С���ˣ�RLS��
plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% ��ͼ
yita(2)=lamda/std(z);
delta(3,:)=zhibiao(theta1,theta12,N1);
delta(4,:)=zhibiao(theta1,theta22,N1);

lamda=0.1;
z=Model2010011452(u_M,lamda);
[J_L1 N13 theta13 t13 z_p]=Ls(u_M,z,Np,10,2);%������С���ˣ�LS��
[J_L2 N23 theta23 t23 theta]=RLS(u_M,z,Np,10,2);%������С���ˣ�RLS��
plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% ��ͼ
yita(3)=lamda/std(z);
delta(5,:)=zhibiao(theta1,theta13,N1);
delta(6,:)=zhibiao(theta1,theta23,N1);
