clear;close all;clc;
deltat=50;%实际采样间隔/s
Np=15;%M序列周期
data=importdata(strcat('data_d1_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata(strcat('data_s3_',num2str(deltat),'s',num2str(Np),'.csv'),',');
t2=datenum(data.textdata);
v2=data.data;
t2=(t2-t1(1))*24*3600;%将时间标准化到秒，以输入开始时间为起点
t1=(t1-t1(1))*24*3600;
%画出原始数据曲线
figure;
subplot(211);hold on;
for i1=1:length(t1)-1
    plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
    plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
end
title('输入：电机电压'),xlabel('时间/s');ylabel('电压');
subplot(212);hold on;
for i1=1:length(t2)-1
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'b');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'b');
end
title('输出：液面高度'),xlabel('时间/s');ylabel('液面高度');
%% 观察并截取输入电压的有效数据片段所在区间youxiao，并确定输出稳态值y0
youxiao=3:78;
y0=140;

%选取有效数据段
t1=t1(youxiao);
v1=v1(youxiao);
%转为二进制
a1=v1>5;
a2=logical([1;xor(a1(2:end),a1(1:end-1))]);
a3=[a1 a2];
t1=t1(a2);
v1=v1(a2);
%变成输入
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
% 抽取相应时间的输出
for i1=1:length(t3)
    index=find(t2<=t3(i1));
    output(i1,1)=v2(index(end));
end

%在原始数据图像中检验输入和输出
subplot(211);
for i1=1:length(input)-1
    plot(t3(i1:i1+1),[input(i1) input(i1)],'--r');
    plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'--r');
end
subplot(212);plot(t3,output,'r*');

%% 将输入标准化到-1和1；将输出减去稳态值
input=2*(input>5)-1;
output=output-y0;
save('data.mat','input','output');