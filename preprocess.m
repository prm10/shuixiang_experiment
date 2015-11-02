clear;close all;clc;
deltat=50;%ʵ�ʲ������/s
Np=15;%M��������
data=importdata(strcat('data_d1_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata(strcat('data_s3_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t2=datenum(data.textdata);
v2=data.data;
t2=(t2-t1(1))*24*3600;%��ʱ���׼�����룬�����뿪ʼʱ��Ϊ���
t1=(t1-t1(1))*24*3600;
%����ԭʼ��������
figure;
subplot(211);hold on;
for i1=1:length(t1)-1
    plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
    plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
end
title('���룺�����ѹ'),xlabel('ʱ��/s');ylabel('��ѹ');
subplot(212);hold on;
for i1=1:length(t2)-1
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'b');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'b');
end
title('�����Һ��߶�'),xlabel('ʱ��/s');ylabel('Һ��߶�');
%% �۲첢��ȡ�����ѹ����Ч����Ƭ����������youxiao����ȷ�������ֵ̬y0
youxiao=3:78;
y0=140;

%ѡȡ��Ч���ݶ�
t1=t1(youxiao);
v1=v1(youxiao);
%תΪ������
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
% ��ȡ��Ӧʱ������
for i1=1:length(t3)
    index=find(t2<=t3(i1));
    output(i1,1)=v2(index(end));
end

%��ԭʼ����ͼ���м�����������
subplot(211);
for i1=1:length(input)-1
    plot(t3(i1:i1+1),[input(i1) input(i1)],'--r');
    plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'--r');
end
subplot(212);plot(t3,output,'r*');

%% �������׼����-1��1���������ȥ��ֵ̬
input=2*(input>5)-1;
output=output-y0;
save('data.mat','input','output');