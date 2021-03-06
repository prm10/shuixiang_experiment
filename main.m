clear;close all;clc;
deltat=25;%实际采样间隔/s
Np=31;%M序列周期
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
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'r');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'r');
end
title('输出：液面高度'),xlabel('时间/s');ylabel('液面高度');
%% 截取输入电压的有效数据片段所在区间youxiao，并确定输出稳态值y0
%15s31
youxiao=4:57;
y0=160;

%50s15
% youxiao=3:78;
% y0=140;

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
    plot(t3(i1:i1+1),[input(i1) input(i1)],'--g');
    plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'--g');
end
subplot(212);plot(t3,output,'*');

%% 将输入标准化到-1和1；将输出减去稳态值
input=2*(input>5)-1;
output=output-y0;
save('data.mat','input','output');
%% 系统辨识
u_M=input;
z=output';

figure;
hold on;
plot(t3,output,'--*');
for i1=1:length(input)-1
    plot(t3(i1:i1+1),[input(i1) input(i1)],'r');
    plot([t3(i1+1) t3(i1+1)],input(i1:i1+1),'r');
end
title('去除稳态值后的增量输入输出');
xlabel('时间/s');
legend('output','input');

%脉冲响应辨识
[g_k]=xgfxf(u_M',output,Np);
figure;
plot(deltat:deltat:deltat*length(g_k),g_k);
title('脉冲响应辨识结果'),xlabel('时间/s');ylabel('g_k');
grid;
figure;
n=Np+1:Np+Np;
for i1=n
    output1(i1-n(1)+1,1)=g_k'*input(i1-1:-1:i1-Np+1);
end
plot(t3(n),output(n),t3(n),output1);
title('脉冲响应辨识重构结果'),xlabel('时间/s');ylabel('液面高度');
legend('真实输出','重构输出');
% %最小二乘辨识
[J_L1, N1 ,theta1 ,t1, z_p]=Ls(u_M,z,Np,10,0);%批量最小二乘（LS）
[J_L2, N2, theta2, t2, theta]=RLS(u_M,z,Np,10,0);%递推最小二乘（RLS）
plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta);% 画图

% index=1:30;
% g2=0.91.^(index-1)*10.7;
% plot(index*deltat,g_k,index*deltat,g2,'--');
% title('脉冲响应辨识结果'),xlabel('时间/s');ylabel('g_k');
% legend('脉冲响应辨识结果','最小二乘辨识结果理论值');