function [g_k]=xgfxf(u_M,z_k,Np)
%% ������ط�������ʶ��ɢ��ϵͳ��������Ӧ
%1. ����M���е�����غ�����
Rm=zeros(Np-1,Np-1);
%�����һ�е�����Np-1����
for k=0:-1:-Np+2
%     k
    m1=u_M(1-k:1-k+Np-1);%�ӵڶ������ڿ�ʼȡ,Np��Ϊ���
    m2=u_M(1:1+Np-1);
    Rm(1,1-k)=sum(m1.*m2)/Np;
end
%������һ��ʱ������һ�е�Np-2�����ݴ���[2:Np-1]��ֻ���һ�е���
for i0=2:Np-1
    Rm(i0,2:Np-1)=Rm(i0-1,1:Np-2);
    Rm(i0,1)=Rm(1,i0);
end
%2. ȡ��M�������rMz
M=zeros(Np-1,Np);
for i0=1:Np
    M(:,i0)=u_M(Np-2+i0:-1:Np-Np+i0);
end
zk=z_k(Np:Np+Np-1);
rMz=1/Np*(M*zk);
%һ������㷨ֱ�ӵó�g_k
g_k=Rm\rMz;