clear;close all;clc;
deltat=25;
Np=31;
data=importdata(strcat('data_d1_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata(strcat('data_s3_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t2=datenum(data.textdata);
v2=data.data;
t2=(t2-t1(1))*24*3600;
t1=(t1-t1(1))*24*3600;
%��ͼ
figure;
subplot(211);hold on;
for i1=1:length(t1)-1
    plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
    plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
end
title('���룺�����ѹ'),xlabel('ʱ��/s');ylabel('��ѹ');
subplot(212);hold on;
for i1=1:length(t2)-1
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'r');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'r');
end
title('�����Һ��߶�'),xlabel('ʱ��/s');ylabel('Һ��߶�');
%15s31
youxiao=4:57;
y0=160;

%50s15
% youxiao=3:78;
% y0=140;
%ѡȡ��Ч���ݶ�
t1=t1(youxiao);
v1=v1(youxiao);
%���01��
a1=v1>5;
a2=logical([1;xor(a1(2:end),a1(1:end-1))]);
a3=[a1 a2];
t1=t1(a2);
v1=v1(a2);
%�������
t0=t1(1);
i2=1;
for i1=1:length(t1)-1
    input(i2,1)=v1(i1);
    t3(i2,1)=t1(i1);
    t0=t0+deltat;
    i2=i2+1;
    while t1(i1+1)-t0>0.5*deltat
        input(i2,1)=v1(i1);
        t3(i2,1)=t0;
        t0=t0+deltat;
        i2=i2+1;
    end
    t0=t1(i1+1);
end
input(i2,1)=v1(end);
t3(i2,1)=t1(end);
%��ͼ��������
% for i1=1:length(input)-1
%     plot(t3(i1:i1+1),[input(i1) input(i1)],'g');
%     plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'g');
% end

input=2*(input>5)-1;
for i1=1:length(t3)
    index=find(t2<=t3(i1));
    output(i1,1)=v2(index(end));
end
%��ͼ�������
% plot(t3,output,'*');

figure;
hold on;
plot(t3,output,'--*');
for i1=1:length(input)-1
    plot(t3(i1:i1+1),[input(i1) input(i1)],'r');
    plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'r');
end
title('ȥ����ֵ̬��������������');
xlabel('ʱ��/s');
legend('output','input');

output=output-y0;
u_M=input;
z=output';

%������Ӧ��ʶ
[g_k]=xgfxf(u_M',output,Np);
figure;
plot(1:deltat:deltat*length(g_k),g_k);
title('������Ӧ��ʶ���'),xlabel('ʱ��/s');ylabel('g_k');
grid;

% %��С���˱�ʶ
% [J_L1, N1 ,theta1 ,t1, z_p]=Ls(u_M,z,Np,10,0);%������С���ˣ�LS��
% [J_L2, N2, theta2, t2, theta]=RLS(u_M,z,Np,10,0);%������С���ˣ�RLS��
% plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% ��ͼ

