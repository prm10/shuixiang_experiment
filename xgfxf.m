function [g_k]=xgfxf(u_M,z_k,Np)
%% 根据相关分析法辨识离散化系统的脉冲响应
%1. 先求M序列的自相关函数：
Rm=zeros(Np-1,Np-1);
%先求第一行的所有Np-1个数
for k=0:-1:-Np+2
%     k
    m1=u_M(1-k:1-k+Np-1);%从第二个周期开始取,Np作为零点
    m2=u_M(1:1+Np-1);
    Rm(1,1-k)=sum(m1.*m2)/Np;
end
%再求下一行时，将上一行的Np-2个数据代入[2:Np-1]，只求第一列的数
for i0=2:Np-1
    Rm(i0,2:Np-1)=Rm(i0-1,1:Np-2);
    Rm(i0,1)=Rm(1,i0);
end
%2. 取出M矩阵，算出rMz
M=zeros(Np-1,Np);
for i0=1:Np
    M(:,i0)=u_M(Np-2+i0:-1:Np-Np+i0);
end
zk=z_k(Np:Np+Np-1);
rMz=1/Np*(M*zk);
%一次完成算法直接得出g_k
g_k=Rm\rMz;