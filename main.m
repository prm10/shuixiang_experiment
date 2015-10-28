clear;close all;clc;
data=importdata('data_d1_15s.csv',',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata('data_s1_15s.csv',',');
t2=datenum(data.textdata);
v2=data.data;
figure,hold on;
for i1=9:length(t1)-1
    plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
    plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
end
% for i1=1:length(t2)-1
%     plot(t2(i1:i1+1),[v2(i1) v2(i1)],'r');
%     plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'r');
% end
% for i1=10:length(t1)-1
%     plot(i1:i1+1,[v1(i1) v1(i1)],'b');
%     plot([(i1+1) (i1+1)],v1(i1:i1+1),'b');
% end
tmin=t1(10);%max([min(t1);min(t2)]);
tmax=min([max(t1);max(t2)]);
n=floor((tmax-tmin)*24*3600/15-1);
for i1=1:n
    t=tmin+i1*15/3600/24+1/3600/24;
    index=find(t1<t);
    input(i1,1)=v1(index(end));
end
figure,hold on;
for i1=1:length(input)-1
    plot(i1:i1+1,[input(i1) input(i1)],'b');
    plot([(i1+1) (i1+1)],input(i1:i1+1),'b');
end


