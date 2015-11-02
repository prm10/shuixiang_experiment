clear;close all;clc;
clc;close all;clear all;
%% 输入M序列，得到输出
% 4阶多项式410：[1 0 0 1]
% 5阶多项式520：[0 1 0 0 1]
% a=1;Np=2^5-1;
% connections=[0 1 0 0 1];%特征多项式(8,7,2,1,0)
% registers=[0 0 0 0 1];%初始值
% len=Np;
% [u_M]=mseq(connections,registers,len,a);
% u_M'
%%
deltat=30;
data=importdata('data_d1_jieyue.csv',',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata('data_s1_jieyue.csv',',');
t2=datenum(data.textdata);
v2=data.data;
t2=(t2-t2(1))*24*3600;
t1=(t1-t2(1))*24*3600;
figure,hold on;
% for i1=1:length(t1)-1
%     plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
%     plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
% end
for i1=1:length(t2)-1
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'r');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'r');
end
title('阶跃响应曲线和时间常数T');xlabel('时间/s');ylabel('液面高度h');

a0=v2(1)+0.632*(v2(end)-v2(1));
ind=find(v2<a0);
T=(t2(ind(end))-t2(1))*24*3600;
plot([t2(1) t2(end)],[v2(ind(end)) v2(ind(end))],'--');